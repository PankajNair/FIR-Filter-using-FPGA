`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2024 22:44:06
// Design Name: 
// Module Name: dff
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


module dff (
input logic clk, reset, 
input logic [15:0] inData,
output logic [15:0] outData
);

always_ff @(posedge clk)
begin
    if(reset)
        outData <= 0;
    else
        outData <= inData;
end

endmodule
