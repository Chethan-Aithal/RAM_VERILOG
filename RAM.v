`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.04.2026 18:12:24
// Design Name: 
// Module Name: RAM
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


module RAM(address,data,clk,read,write,cs );

input[9:0]address;
inout[7:0]data;
input read,write,cs;

input clk;


reg[7:0]memory[1023:0];  //1kbyte
reg[7:0]d_out;// it used in always block for data(since inout)

assign data=(cs&&read)?d_out:8'bz;

always@(posedge clk)
begin
if(cs&&write&&!read)
   memory[address]<=data;//write operation
end
   
always@(posedge clk)
begin
if(cs&&read&&!write)
d_out<=memory[address];//read   operation 
end
endmodule
