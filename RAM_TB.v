`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.04.2026 18:31:27
// Design Name: 
// Module Name: RAM_TB
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


`timescale 1ns/1ps

module RAM_TB;

reg clk;
reg read, write, cs;
reg [9:0] address;
reg [7:0] data_in;
wire [7:0] data;

// Connect data bus (for inout)
assign data = (write && cs) ? data_in : 8'bz;

// Instantiate RAM
RAM uut (
    .clk(clk),
    .address(address),
    .data(data),
    .read(read),
    .write(write),
    .cs(cs)
);

// Clock generation
always #5 clk = ~clk;

// Monitor
initial begin
    $monitor("T=%0t | Addr=%0d | Data=%h | Read=%b Write=%b",
              $time, address, data, read, write);
end

initial begin
    clk = 0;
    cs = 1;
    read = 0;
    write = 0;
    address = 0;
    data_in = 0;

    // ---------------- WRITE ----------------
    #10;
    write = 1; read = 0;
    address = 10; data_in = 8'hAA;   // Write AA

    #10;
    address = 20; data_in = 8'h55;   // Write 55

    #10;
    write = 0;

    // ---------------- READ ----------------
    #10;
    read = 1; write = 0;
    address = 10;

    #10;
    address = 20;

    #10;
    read = 0;

    #20;
    $stop;
end

endmodule
