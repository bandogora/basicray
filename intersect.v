`include "dot_product.v"
`include "vec_sub.v"
`include "vec_scale.v"

module intersect(dir, rad, out);

// oc = r.origin() - center;
//  a = dot(r.direction(), r.direction());
//  b = 2.0 * dot(oc, r.direction());
//  c = dot(oc, oc) - radius*radius;
//  discriminant = b*b - 4*a*c;
//  temp = discriminant > 0;

// define Inputs
input [191:0] dir;
input [63:0] rad;

// define Outputs
output out;

// create the origin vector (will not be static in future versions)
reg [191:0] origin = 0;

// create the center vector (will not be static in future versions)
wire [191:0] center;
assign center[191:128] = 0;
assign center[127:63] = 0;
assign center[63:0] = $realtobits(-1);

// define wires to connect modules
wire [191:0] oc1;
wire [63:0] a1;
wire [63:0] b1;
wire [63:0] c1;

// define regs used between modules
reg [191:0] oc2;
reg [63:0] a2;
reg [63:0] b2;
reg [63:0] c2;
reg [63:0] d;
reg e;

// assign output to funtion end
assign out = e;

// define module instances
vec_sub vec_sub1 (
  .i(origin),
  .n(center),
  .rem(oc1)
);
dot_product dot_product1 (
  .i(dir),
  .n(dir),
  .dot(a1)
);
dot_product dot_product2 (
  .i(oc2),
  .n(dir),
  .dot(b1)
);
dot_product dot_product3 (
  .i(oc2),
  .n(oc2),
  .dot(c1)
);

always @(oc1) begin
  oc2 = oc1;
end

always @(a1) begin
  a2 = a1;
end

always @(b1) begin
  b2 = $bitstoreal($realtobits(2) * $realtobits(b1));
end

// c1 will be last output
always @(c1) begin
  c2 = $realtobits($bitstoreal(c1) - $bitstoreal(rad) * $bitstoreal(rad));
  d = $realtobits($bitstoreal(b2) * $bitstoreal(b2) - 4 * $bitstoreal(a2) * $bitstoreal(c2));
  if ($bitstoreal(d) > 0) begin
    e = 1;
  end
  else begin
    e = 0;
  end
end

endmodule