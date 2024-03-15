`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.11.2023 00:52:15
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

parameter N = 16;
reg clk = 0, reset;
reg [N-1:0] dataIn;  
wire [N-1:0] dataOut; 

filter uut(clk, reset, dataIn, dataOut);

always
#5 clk = ~clk;

reg [N-1:0] RAMM [31:0];
reg [4:0] address;

initial
$readmemb("signalBin.data", RAMM);

initial 
address = 0;

always
begin
     reset = 1'b0;
     #5
     reset = 1'b1;
     address = address+1;
     dataIn = RAMM[address];
end

//integer file, i;
//initial
//begin
//    reset = 1'b1;
//    #10
//    reset = 1'b0;
//    #10
//    file = $fopen("signalAnalog.data","r");
//    for(i=0;i<32;i=i+1)
//    begin
//       $fscanf(file,"%d",in);
//       #10;
//   end
//end

endmodule
