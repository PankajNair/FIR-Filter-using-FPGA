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
input logic clk, enable,
input logic signed [15:0] inData,
output logic signed [15:0] outData
);

logic signed [15:0] b [0:31];

assign b = {16'h0063, 16'h008a, 16'h00da, 16'h0162, 16'h022c, 16'h033f, 16'h0499, 16'h0633, 
            16'h07ff, 16'h09e8, 16'h0bd4, 16'h0da9, 16'h0f4b, 16'h109e, 16'h118e, 16'h120a, 
            16'h120a, 16'h118e, 16'h109e, 16'h0f4b, 16'h0da9, 16'h0bd4, 16'h09e8, 16'h07ff, 
            16'h0633, 16'h0499, 16'h033f, 16'h022c, 16'h0162, 16'h00da, 16'h008a, 16'h0063};

logic signed [15:0] x [0:31];
logic signed [31:0] mul [0:31];
logic signed [32:0] sumInt1 [0:7];
logic signed [33:0] sumInt2 [0:1];
logic signed [34:0] sum;

genvar i;
dff DFF(clk, enable, inData, x[0]);
generate
    for (i=1; i<32; i++) 
        begin: FlipFlop_Block
            dff DFF(clk, enable, x[i-1], x[i]);
        end
endgenerate

always @(posedge clk)
begin
    for(int i=0;i<32;i++)
        mul[i] <= x[i]*b[i];
end

always @(posedge clk)
begin
    sumInt1[0] <= mul[0]+mul[1]+mul[2]+mul[3];
    sumInt1[1] <= mul[4]+mul[5]+mul[6]+mul[7];
    sumInt1[2] <= mul[8]+mul[9]+mul[10]+mul[11];
    sumInt1[3] <= mul[12]+mul[13]+mul[14]+mul[15];
    sumInt1[4] <= mul[16]+mul[17]+mul[18]+mul[19];
    sumInt1[5] <= mul[20]+mul[21]+mul[22]+mul[23];
    sumInt1[6] <= mul[24]+mul[25]+mul[26]+mul[27];
    sumInt1[7] <= mul[28]+mul[29]+mul[30]+mul[31];
end

always @(posedge clk)
begin
    sumInt2[0] <= sumInt1[0]+sumInt1[1]+sumInt1[2]+sumInt1[3];
    sumInt2[1] <= sumInt1[4]+sumInt1[5]+sumInt1[6]+sumInt1[7];
end

always @(posedge clk)
begin
    sum <= sumInt2[0]+sumInt2[1];
end

assign outData = sum[18:3];

endmodule