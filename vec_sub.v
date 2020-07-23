module vec_sub(i, n, rem);

// Define Inputs
input [191:0] i, n;

// Define Outputs
output [191:0] rem;

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
reg [191:128] temp1;
reg [127:64] temp2;
reg [63:0] temp3;

assign rem = {$realtobits(temp3), $realtobits(temp2), $realtobits(temp1)};

always @(i & n) begin
    temp3 = $bitstoreal(ix) - $bitstoreal(nx);
    temp2 = $bitstoreal(iy) - $bitstoreal(ny);
    temp1 = $bitstoreal(iz) - $bitstoreal(nz);
end

endmodule