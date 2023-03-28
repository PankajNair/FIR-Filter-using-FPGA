module fir(clk, rst, data_in, data_out);
parameter N = 16;
input clk, rst; 
input [N-1:0] data_in; 
output reg [N-1: 0] data_out; 

// 3rd Order Moving Average Filter. Four coefficients => 1/4 = 0.25
// To convert from floating point => 0.25 x 128 = 32

wire [5:0] b0 = 6'b100000;
wire [5:0] b1 = 6'b100000;
wire [5:0] b2 = 6'b100000;
wire [5:0] b3 = 6'b100000;

// Creating Delays:

wire [N-1:0] x1, x2, x3;
DFF DFF0(clk, 1'b0, data_in, x1); // x[n-1]
DFF DFF1(clk, 1'b0, x1, x2);      // x[n-2]
DFF DFF2(clk, 1'b0, x2, x3);      // x[n-3]

// Mulplication Operations:

wire [N-1:0] mul0, mul1, mul2, mul3;
assign mul0 = data_in * b0;
assign mul1 = x1 * b1;
assign mul2 = x2 * b2;
assign mul3 = x3 * b3;

// Addition Operations:

wire [N-1:0] finalAdd;
assign finalAdd = mul0 + mul1 + mul2 + mul3;

// Final Output:

always @(posedge clk)
begin
    data_out <= finalAdd;
end

endmodule

// ------------------------------------------------------------------------------------------------

module DFF(clk, rst, data_in, data_delayed);
parameter N = 16;
input clk, rst; 
input [N-1:0] data_in; 
output reg [N-1: 0] data_delayed;   

always @(posedge clk, posedge rst)
begin
    if(rst)
        data_delayed <= 0;
    else
        data_delayed <= data_in;  
end

endmodule