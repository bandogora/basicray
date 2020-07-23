`include "../dot_product.v"
module dot_product_tb();

reg [191:0] i, n;
wire [63:0] dot;

initial begin
  i[191:128] = $realtobits(12.54);
  i[127:64] = $realtobits(14.67);
  i[63:0] = $realtobits(-16);

  n[191:128] = $realtobits(-3);
  n[127:64] = $realtobits(-2.234);
  n[63:0] = $realtobits(1.234);

  

  $display("Input i = {%g, %g, %g}", $bitstoreal(i[191:128]), $bitstoreal(i[191:128]), $bitstoreal(i[63:0]));
  $display("Input n = {%g, %g, %g}", $bitstoreal(n[191:128]), $bitstoreal(n[191:128]), $bitstoreal(n[63:0]));
  $monitor("Output =  %b", dot);
end

dot_product U_dot_product(i, n, dot);

endmodule