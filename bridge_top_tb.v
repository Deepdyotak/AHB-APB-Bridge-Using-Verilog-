`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.09.2025 00:22:15
// Design Name: 
// Module Name: bridge_top_tb
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


module bridge_top_tb( );
reg hclk;
reg hresetn;
wire [31:0]haddr,hwdata,hrdata,paddr,prdata,pwdata,paddr_out,pwdata_out;
wire hwrite,hreadyin;
wire [1:0]htrans;
wire [1:0]hresp;
wire penable,pwrite,hreadyout,pwrite_out,penable_out;
wire [2:0]pselx,pselx_out;
wire [31:0] prdata_out;

AHB_master  ahb(hclk,hresetn,hreadyout,hrdata, 
hwrite,hreadyin,haddr,hwdata,
htrans);

Bridge_top bridge(hclk,hresetn,hwrite,hreadyin,
htrans,
haddr,hwdata,prdata,
hresp,
hrdata,hreadyout,
pwrite,penable,pselx,
pwdata,paddr);

APB_Interface apb(pwrite,penable,pselx,pwdata,paddr,
prdata,pwrite_out,penable_out,pselx_out,pwdata_out,paddr_out,prdata_out);

initial begin
hclk = 0;
forever #5 hclk = ~hclk;
end

task reset();
begin
@(posedge hclk) hresetn = 0;
@(posedge hclk) hresetn = 1;
end
endtask 

initial begin 
reset;
//#100 ahb.singlewrite();
//#100 ahb.singleread();
//#100 ahb.burst_incr4_read();
#100 ahb.burst_incr4_write();
#500 $finish;
end



endmodule

