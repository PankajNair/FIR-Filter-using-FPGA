`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.11.2023 00:51:18
// Design Name: 
// Module Name: filter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

(* use_dsp = "yes" *)
module filter #(parameter N = 16) (
input clk, reset,
input [N-1:0] dataIn,
output reg [N-1:0] dataOut
);

wire [5:0] b0 = 6'b000101;
wire [5:0] b1 = 6'b011111;
wire [5:0] b2 = 6'b111001;
wire [5:0] b3 = 6'b011111;
wire [5:0] b4 = 6'b000101;

wire [N-1:0] x1, x2, x3, x4;
dff DFF0(clk, 1'b0, dataIn, x1); 
dff DFF1(clk, 1'b0, x1, x2);  
dff DFF2(clk, 1'b0, x2, x3); 
dff DFF3(clk, 1'b0, x3, x4); 

wire [N-1:0] mul0, mul1, mul2, mul3, mul4;
assign mul0 = dataIn*b0;
assign mul1 = x1*b1;
assign mul2 = x2*b2;
assign mul3 = x3*b3;
assign mul4 = x4*b4;

wire [N-1:0] finalAdd;
assign finalAdd = mul0+mul1+mul2+mul3+mul4;

always @(posedge clk)
begin
    dataOut <= finalAdd;
end

endmodule
