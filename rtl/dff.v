`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.11.2023 00:55:20
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


module dff #(parameter N = 16) (
input clk, reset, 
input [N-1:0] dataIn,
output reg [N-1:0] dataOut
);

always @(posedge clk)
begin
    if(reset)
        dataOut <= 0;
    else
        dataOut <= dataIn;
end

endmodule
