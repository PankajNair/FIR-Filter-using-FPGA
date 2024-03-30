`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.03.2024 03:21:38
// Design Name: 
// Module Name: filterTop
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


module filterTop(
input logic clk, button,
input logic [1:0] JA,
output logic [7:0] JE
    );
    
logic [4:0] channel_out;
logic [6:0] daddr_in;
logic eoc_out;
logic [15:0] do_out;
logic analogP, analogN, convst, drdy;
logic [9:0] count;
logic [15:0] x,y;

assign daddr_in = {2'b0, channel_out};

assign analogP = JA[1];
assign analogN = JA[0];

assign x = $signed(do_out);
assign JE = $unsigned(y[15:8]);

filter myFilter (
.clk(clk), 
.enable(eoc_out),
.inData(x),
.outData(y)
);

xadc_wiz_0 myXADC (
  .di_in(16'b0),              // input wire [15 : 0] di_in
  .daddr_in(daddr_in),        // input wire [6 : 0] daddr_in
  .den_in(eoc_out),            // input wire den_in
  .dwe_in(1'b0),            // input wire dwe_in
  .drdy_out(drdy),        // output wire drdy_out
  .do_out(do_out),            // output wire [15 : 0] do_out
  .dclk_in(clk),          // input wire dclk_in
  .reset_in(button),        // input wire reset_in
  .convst_in(convst),      // input wire convst_in
  .vp_in(1'b0),              // input wire vp_in
  .vn_in(1'b0),              // input wire vn_in
  .vauxp6(analogP),            // input wire vauxp6
  .vauxn6(analogN),            // input wire vauxn6
  .channel_out(channel_out),  // output wire [4 : 0] channel_out
  .eoc_out(eoc_out),          // output wire eoc_out
  .alarm_out(1'bz),      // output wire alarm_out
  .eos_out(1'bz),          // output wire eos_out
  .busy_out(1'bz)        // output wire busy_out
);

always_ff @(posedge clk)
begin
    if(count == 999)
        begin
            count <= 0;
            convst <= 1'b1;
        end
    else
        begin
            count <= count+1;
            convst <= 1'b0;
        end
end

endmodule