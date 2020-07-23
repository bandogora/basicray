`include "../vec_scale.v"
module vec_scale_tb();

reg [95:0] i;
reg [31:0] n;
wire [95:0] prod;

initial begin
  i[95:64] = 12.54;
  i[63:32] = 14.67;
  i[31:0] = -16;

  n[31:0] = 1.734;

  $display("Input i = {%g, %g, %g}", i[95:64], i[63:32], i[31:0]);
  $display("Input n = %g", n);
  $monitor("Output = {%g, %g, %g}", prod[95:64], prod[63:32], prod[31:0]);
  
end

vec_scale U_vec_scale(i, n, prod);

endmodule