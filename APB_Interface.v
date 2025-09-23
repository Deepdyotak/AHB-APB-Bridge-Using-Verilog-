`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.09.2025 20:15:13
// Design Name: 
// Module Name: APB_Interface
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


module APB_Interface(input pwrite,penable,
input[2:0] pselx,
input [31:0] pwdata,paddr,
output reg [31:0] prdata,
output pwrite_out,penable_out,
output [2:0] pselx_out,
output [31:0] pwdata_out,paddr_out,prdata_out);
// when read operation it will give prdata 
assign pwrite_out  = pwrite;
assign paddr_out   = paddr;
assign pselx_out    = pselx;
assign pwdata_out  = pwdata;
assign penable_out = penable;
assign prdata_out = prdata;
always@(*) begin
if(~pwrite && penable) 
  prdata = {$random}%1024;
else
  prdata = 32'hDEAD;
end
    
endmodule
