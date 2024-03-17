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

localparam cordic_period = 2;
localparam fir_period = 10;
localparam signed [15:0] pi_pos = 16'h6488;
localparam signed [15:0] pi_neg = 16'h9B78;
localparam phase_inc_2Mhz = 200;
localparam phase_inc_30Mhz = 3000;

logic cordic_clk = 1'b0;
logic fir_clk = 1'b0;
logic phase_tvalid = 1'b0;
logic signed [15:0] phase_2Mhz = 0;
logic signed [15:0] phase_30Mhz = 0;
logic sincos_2Mhz_tvalid;
logic signed [15:0] sin_2Mhz, cos_2Mhz;
logic sincos_30Mhz_tvalid;
logic signed [15:0] sin_30Mhz, cos_30Mhz;

logic signed [15:0] noisy_signal = 0;
logic signed [15:0] filtered_signal;

cordic_0 cordic_inst_0 (
.aclk(cordic_clk),
.s_axis_phase_tvalid(phase_tvalid),
.s_axis_phase_tdata(phase_2Mhz),
.m_axis_dout_tvalid(sincos_2Mhz_tvalid),
.m_axis_dout_tdata({sin_2Mhz, cos_2Mhz})
);

cordic_0 cordic_inst_1 (
.aclk(cordic_clk),
.s_axis_phase_tvalid(phase_tvalid),
.s_axis_phase_tdata(phase_30Mhz),
.m_axis_dout_tvalid(sincos_30Mhz_tvalid),
.m_axis_dout_tdata({sin_30Mhz, cos_30Mhz})
);

always_ff @(posedge cordic_clk)
begin
    phase_tvalid <= 1'b1;
    
    if(phase_2Mhz+phase_inc_2Mhz<pi_pos)
        phase_2Mhz <= phase_2Mhz+phase_inc_2Mhz;
    else
        phase_2Mhz <= pi_neg+(phase_2Mhz+phase_inc_2Mhz - pi_pos);
    
    if(phase_30Mhz+phase_inc_30Mhz<pi_pos)
        phase_30Mhz <= phase_30Mhz+phase_inc_30Mhz;
    else
        phase_30Mhz <= pi_neg+(phase_30Mhz+phase_inc_30Mhz - pi_pos);
end

always
    cordic_clk = #(cordic_period/2) ~cordic_clk;
    
always
    fir_clk = #(fir_period/2) ~fir_clk;
    
always @(posedge fir_clk)
begin
    noisy_signal <= (sin_2Mhz+sin_30Mhz)/2;
end

filter uut(
.clk(fir_clk), 
.inData(noisy_signal),
.outData(filtered_signal)
);

endmodule

