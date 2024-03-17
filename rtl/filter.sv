`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2024 22:37:27
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

module filter (
input logic clk,
input logic signed [15:0] inData,
output logic signed [15:0] outData
);

logic signed [15:0] b [0:8];

assign b = {16'h0231, 16'h06ac, 16'h1249, 16'h1ecf, 16'h2433, 16'h1ecf, 16'h1249, 16'h06ac, 16'h0231};

logic signed [15:0] x [0:8];
logic signed [31:0] mul [0:8];
logic signed [32:0] sumInt [0:2];
logic signed [33:0] sum;

genvar i;
dff DFF(clk, 1'b0, inData, x[0]);
generate
    for (i=1; i<9; i++) 
        begin: FlipFlop_Block
            dff DFF(clk, 1'b0, x[i-1], x[i]);
        end
endgenerate

always @(posedge clk)
begin
    for(int i=0;i<9;i++)
        mul[i] <= x[i]*b[i];
end

always @(posedge clk)
begin
    sumInt[0] <= mul[0]+mul[1]+mul[2];
    sumInt[1] <= mul[3]+mul[4]+mul[5];
    sumInt[2] <= mul[6]+mul[7]+mul[8];
end

always @(posedge clk)
begin
    sum <= sumInt[0]+sumInt[1]+sumInt[2];
end

assign outData = sum[33:18];

endmodule
