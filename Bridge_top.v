`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.09.2025 17:25:23
// Design Name: 
// Module Name: Bridge_top
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


module Bridge_top(input hclk,hresetn,hwrite,hreadyin,
input [1:0] htrans,
input[31:0] haddr,hwdata,prdata,
output [1:0] hresp,
output [31:0] hrdata,
output hreadyout,
output  pwrite,penable,
output  [2:0] pselx,
output  [31:0] pwdata,paddr);

wire valid,hwritereg;
wire [31:0] haddr1,haddr2,hwdata1,hwdata2;
wire [2:0] tempselx;


AHB_slave_interface ASI(hclk,hresetn,hwrite,hreadyin,htrans,haddr,hwdata,prdata,hresp,hrdata,hreadyout,valid,hwritereg,haddr1,haddr2,hwdata1,hwdata2,tempselx);

APB_controller AC(hclk,hresetn,hwrite,valid,hwritereg,
haddr,haddr1,haddr2,hwdata,hwdata1,hwdata2,prdata,
tempselx,
pwrite,penable,hreadyout,
pselx,
pwdata,paddr);

endmodule
