#include "ray.h"
#include "vec3.h"

#include <chrono>
#include <fstream>
#include <iostream>
#include <typeinfo>

int count = 0;

void make_test(const float r[3], float rad, bool out) {
  std::fstream f;
  std::string name = "intersect_tests/intersect_tb" + std::to_string(count) + ".v";
  f.open(name, std::fstream::out);
  f << "`include \"intersect.v\"" << std::endl;
  f << "module intersect_tb();" << std::endl;
  f << "reg [191:0] dir;" << std::endl;
  f << "reg [63:0] rad;" << std::endl;
  f << "wire out;" << std::endl;
  f << "initial begin" << std::endl;
  f << "  dir[191:128] = $realtobits(" << r[0] << ");" << std::endl;
  f << "  dir[127:64] = $realtobits(" << r[1] << ");" << std::endl;
  f << "  dir[63:0] = $realtobits(" << r[2] << ");" << std::endl;
  f << "  rad = $realtobits(" << rad << ");" << std::endl;
  f << "  $monitor(\"%b\", out);" << std::endl;
  f << "end" << std::endl;
  f << "intersect U_intersect(dir, rad, out);" << std::endl;
  f << "endmodule" << std::endl;
  f.close();
  count++;
}

bool hit_sphere(const point3& center, float radius, const ray& r) {
  vec3 oc = r.origin() - center;
  float a = dot(r.direction(), r.direction());
  float b = 2.0 * dot(oc, r.direction());
  float c = dot(oc, oc) - radius*radius;
  float discriminant = b*b - 4*a*c;
  bool temp = discriminant > 0;
  make_test(r.dir.e, radius, temp);
  if (temp) {
    std::cout << temp << std::endl;
  }
  std::cout << temp << std::endl;
  return (temp);
}

color ray_color(const ray& r) {
  if (hit_sphere(point3(0,0,-1), 0.5, r)) {
    return color(1, 0, 0);
  }

  vec3 unit_direction = unit_vector(r.direction());
  auto t = 0.5 * (unit_direction.y() + 1.0);
  return (1.0-t) * color(1.0, 1.0, 1.0) + t * color(0.5, 0.7, 1.0);
}

int main() {
  const auto aspect_ratio = 16.0 / 9.0;
  const int image_width = 384;
  const int image_height = static_cast<int>(image_width / aspect_ratio);

  auto viewport_height = 2.0;
  auto viewport_width = aspect_ratio * viewport_height;
  auto focal_length = 1.0;

  auto origin = point3(0, 0, 0);
  auto horizontal = vec3(viewport_width, 0, 0);
  auto vertical = vec3(0, viewport_height, 0);
  auto lower_left_corner = origin - horizontal/2 - vertical/2 - vec3(0, 0, focal_length);

  for (int j = image_height-1; j >= 0; --j) {
    for (int i = 0; i < image_width; ++i) {
      auto u = double(i) / (image_width-1);
      auto v = double(j) / (image_height-1);
      ray r(origin, lower_left_corner + u*horizontal + v*vertical - origin);
      color pixel_color = ray_color(r);
    }
  }

  std::fstream f;
  f.open("intersect_tests/run_tbs.sh", std::fstream::out);
  f << "#!/bin/bash" << std::endl;
  f << std::endl;
  f << "V=0" << std::endl;
  f << "while [ $V -le "  << count << " ]" << std::endl;
  f << "do" << std::endl;
  f << "  iverilog -o intersect_$V intersect_tb$V.v &> /dev/null" << std::endl;
  f << "  vvp intersect_$V >> results_v" << std::endl;
  f << "  ((V++))" << std::endl;
  f << "done" << std::endl;
  f << "results_c:" << std::endl;
  f << "awk '{print $1}' results_c | sort | uniq -c" << std::endl;
  f << "results_v:" << std::endl;
  f << "awk '{print $1}' results_v | sort | uniq -c" << std::endl;
  f.close();

  return(0);
}