`include "../vec_sub.v"
module vec_sub_tb();

reg [191:0] i, n;
wire [191:0] rem;

reg [128:0] temp;

initial begin
  i[191:128] = 0;
  i[127:64] = 0;
  i[63:0] = 0;

  n[191:128] = 0;
  n[127:64] = 0;
  n[63:0] = $realtobits(-1);

  $display("Input i = {%g, %g, %g}", $bitstoreal(i[191:128]), $bitstoreal(i[127:64]), $bitstoreal(i[63:0]));
  $display("Input n = {%g, %g, %g}", $bitstoreal(n[191:128]), $bitstoreal(n[127:64]), $bitstoreal(n[63:0]));
  $monitor("Output = {%b, %b, %b}", rem[191:128], rem[127:64], rem[63:0]);
end

vec_sub U_vec_sub(i, n, rem);

endmodule