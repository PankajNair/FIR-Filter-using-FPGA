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
input logic clk, reset,
input logic signed [15:0] inData,
output logic signed [15:0] outData
);

logic [15:0] b [0:8];
logic [15:0] x [0:7];
logic [31:0] mul [0:8];
logic [31:0] sumInt [0:2];
logic [31:0] sum;

assign b = {16'h04F6, 16'h0AE4, 16'h1089, 16'h1496, 16'h160F,
            16'h1496, 16'h1089, 16'h0AE4, 16'h04F6};

genvar i;
dff DFF0(clk, reset, inData, x[0]);
generate
    for (i=1; i<8; i++) 
        begin: FlipFlop_Block
            dff DFF(clk, reset, x[i-1], x[i]);
        end
endgenerate

always_comb
begin
    mul[0] = inData*b[0];
    for(int i=1; i<5; i++)
        mul[i] = x[i-1]*b[i];
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

always_ff @(posedge clk)
begin
    outData <= sum;
end

endmodule