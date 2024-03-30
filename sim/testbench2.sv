`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.03.2024 21:39:31
// Design Name: 
// Module Name: testbench2
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


module testbench2();

logic clk = 0, enable;
logic [15:0] inData;
logic [15:0] outData;

filter uut(
.clk(clk), 
.enable(enable),
.inData(inData),
.outData(outData)
);

always 
    #5 clk = !clk;
    
logic [15:0] mem [0:99];
logic [6:0] address = 0;

initial
    $readmemb("signalBin.data", mem);
    
always_ff @(posedge clk)
begin
    inData <= mem[address];
    if(address == 7'd99)
        address = 0;
    else
        address = address+1;
end


endmodule
