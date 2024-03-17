# FIR Filter using FPGA
The design of a 9-tap FIR with a cut-off frequency of 10 MHz and sampling frequency of 100 MHz. 

Architecture:
![filter](https://github.com/PankajNair/FIR-Filter-using-FPGA/blob/main/filter.png)

The MAC operation is pipelined to prevent timing violations. The 'fir.ipynb' file calculates the filter coefficients based on the sampling frequency and cut-off frequency provided by the user. Hence, the filter coefficients in the design can be changed to design a low-pass filter or high-pass filter.
