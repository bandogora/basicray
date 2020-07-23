`include "intersect.v"

module intersect_tb();

reg [191:0] dir;
reg [63:0] rad;
wire out;

initial begin
  dir[191:128] = $realtobits(-0.0696257353);
  dir[127:64] = $realtobits(0.57209301);
  dir[63:0] = $realtobits(-1);

  rad = $realtobits(0.5);
  
  //$display("Input dir = {%g, %g, %g}", dir[95:64], dir[63:32], dir[31:0]);
  //$display("Input rad = %g", rad);
  $monitor("%b", out);
end

intersect U_intersect(dir, rad, out);

endmodule