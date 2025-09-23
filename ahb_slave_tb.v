`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.09.2025 18:20:10
// Design Name: 
// Module Name: ahb_slave_tb
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


module ahb_slave_tb();
reg hclk,hresetn,hwrite,hreadyin;
reg [1:0] htrans;
reg [31:0] haddr,hwdata,prdata;
wire [1:0] hresp;
wire [31:0] hrdata;
wire hreadyout;
wire valid,hwritereg;
wire [31:0] haddr1,haddr2,hwdata1,hwdata2;
wire [2:0] tempselx;
AHB_slave_interface DUT(hclk,hresetn,hwrite,hreadyin,htrans,haddr,hwdata,prdata,hresp,hrdata,hreadyout,valid,hwritereg,haddr1,haddr2,hwdata1,hwdata2,tempselx);

  always #5 hclk = ~hclk;

  initial begin

    hclk = 0;
    hresetn = 0; 
    hwrite = 0;
    hreadyin = 1;
    htrans = 2'b00;
    haddr = 32'h0;
    hwdata = 32'h0;
    prdata = 32'hABCDEF;

    
    #10 hresetn = 1;  
     

    // write operation
    hwrite = 1;
    htrans = 2'b10; // NONSEQ
    haddr  = 32'h80000010;//10ns
    hwdata = 32'h12345678; //10ns
    #10;
    hwdata = 32'h87654321; //20 ns 
    #10;

    //Read operation
    hwrite = 0; //30ns 
    htrans = 2'b11; // SEQ
    haddr  = 32'h84000020;
    prdata = 32'hCAFE;
    #10;

    // Invalid address (outside range)
    haddr = 32'h70000000; //40 ns address outside range valid 0
    htrans = 2'b10;
    #10;

    $stop;
  end
initial begin 
$monitor($time,"haddr = %h,hwdata=%h,hrdata=%h",haddr,hwdata,hrdata);end


endmodule
