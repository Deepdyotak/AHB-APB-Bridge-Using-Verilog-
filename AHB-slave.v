`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Deep Dyotak Dash
// 
// Create Date: 01.09.2025 13:02:11
// Design Name: 
// Module Name: AHB_slave_interface
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
// hwrite = 0 means read operation and if hwrite =1 then wread operation

module AHB_slave_interface(input hclk,hresetn,hwrite,hreadyin,
input [1:0] htrans,
input[31:0] haddr,hwdata,prdata,
output [1:0] hresp,
output [31:0] hrdata,
output hreadyout,
output reg  valid,hwritereg,
output reg [31:0] haddr1,haddr2,hwdata1,hwdata2,
output reg [2:0] tempselx);

// Handling the input  address through haddr
always@(posedge(hclk)) begin
  if(~hresetn) begin
    haddr1 <=0;
    haddr2 <=0; end
  else begin 
    haddr1 <= haddr;
    haddr2 <= haddr1; end 
    end 
// Handling the write operation
always@(posedge(hclk)) begin
  if(~hresetn) begin
    hwdata1 <=0;
    hwdata2 <=0; end
  else begin 
    hwdata1 <= hwdata;
    hwdata2 <= hwdata1;end
    end 
// implementing hwrite signal
always@(posedge(hclk)) begin
  if(~hresetn) hwritereg <= 0;
  else hwritereg <= hwrite; end
// valid logic generation , it is a combinational block 
always@(*) begin 
  if((haddr>=32'h80000000 && haddr<=32'h8C000000) && (htrans== 2'b10 || htrans == 2'b11)) valid = 1;
  else valid = 0; 
  end
//implementing tempselect
always @(*) begin
  if(haddr >= 32'h80000000 && haddr< 32'h84000000) tempselx = 3'b001;
  else if(haddr >= 32'h84000000 && haddr< 32'h88000000) tempselx = 3'b010;
  else if(haddr >= 32'h88000000 && haddr< 32'h8C000000) tempselx = 3'b100;
  end  
//prdata is the data read from apb bus controller 
assign hrdata = prdata;
assign hresp = 2'b00;
endmodule
