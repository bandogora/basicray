module vec_scale(i, s, prod);

// Define Inputs
input clk;
input [95:0] i;
input [31:0] s;

// Define Outputs
output [95:0] prod;

// Break vectors into components
wire [31:0] ix, iy, iz;

assign ix = i[95:64];
assign iy = i[63:32];
assign iz = i[31:0];

// Temp product store
reg [95:64] temp1;
reg [63:32] temp2;
reg [31:0] temp3;

assign prod = {temp3, temp2, temp1};

always @(ix & iy & iz & s) begin
    temp3 = ix * s;
    temp2 = iy * s;
    temp1 = iz * s;
end

endmodule