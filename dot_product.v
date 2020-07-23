module dot_product (i, n, dot);

// Define Inputs
input clk;
input [191:0] i, n;

// Define Outputs
output [63:0] dot;

// Break vectors into components
wire [63:0] ix, iy, iz;
wire [63:0] nx, ny, nz;

assign ix = i[191:128];
assign iy = i[127:64];
assign iz = i[63:0];
assign nx = n[191:128];
assign ny = n[127:64];
assign nz = n[63:0];

// Temp product store
reg [63:0] temp;

assign dot = temp;

always @(i & n) begin
    temp = $realtobits($bitstoreal(ix) * $bitstoreal(nx) + $bitstoreal(iy) * $bitstoreal(ny) + $bitstoreal(iz) * $bitstoreal(nz));
    temp = $realtobits($bitstoreal(temp) * 10);
end

endmodule