module fir_tb();
parameter N = 16;
reg clk, rst; 
reg [N-1:0] data_in; 
wire [N-1: 0] data_out; 

fir uut(clk, rst, data_in, data_out);

// Signal Data

initial
$readmemb("signal.data", RAMM);

// Creating the RAM

reg [N-1:0] RAMM [31:0];

// Creating the Clock

initial 
clk = 0;
always
#10 clk = ~clk;

// Reading RAMM and giving it to design

always @(posedge clk)
begin
    data_in <= RAMM[address];
end

// Address Counter

reg [4:0] address;
initial address = 1;
always @(posedge clk)
begin
    if(address == 31)
    address = 0;
    else
    address = address+1;
end

initial 
begin
    $dumpfile("fir_tb.vcd.vcd");
    $dumpvars(0,fir_tb);
end
endmodule