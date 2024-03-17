`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2024 22:40:57
// Design Name: 
// Module Name: filterTB
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


module filterTB();

logic clk = 0, reset;
logic [15:0] inData;  
logic [15:0] outData; 

filter uut(clk, reset, inData, outData);

always
#5 clk = ~clk;

logic [15:0] RAMM [0:99];
logic [6:0] address;

initial
$readmemb("signalBin.data", RAMM);

initial 
address = 0;

always
begin
     reset = 1'b0;
     #5
     reset = 1'b1;
     if(address == 7'd99)
        address = 0;
     else
        address = address+1;
     inData = RAMM[address];
end
endmodule
