`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.09.2025 17:51:38
// Design Name: 
// Module Name: AHB_master
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

module AHB_master(input hclk,hresetn,hreadyout, input[31:0]hrdata, 
output reg hwrite,hreadyin, output reg [31:0]haddr,hwdata,
output reg[1:0]htrans);

reg [2:0] hburst;
reg [2:0] hsize;
integer i=0;
task singlewrite();
begin
@(posedge hclk)
#1;
begin  
hwrite = 1;
htrans = 2'd2;
hsize = 0;
hburst = 0;
hreadyin = 1;
haddr = 32'h80000000;
end
@(posedge hclk)
#1;
begin 
hwrite = 0;
hwdata = 32'h24;
htrans = 2'd0;
end 
end
endtask


task singleread();
begin @(posedge hclk) 
#1
begin 
hwrite = 0;
htrans = 2'd2;
hsize = 0;
hburst = 0;
hreadyin = 1;
haddr = 32'h80000000;
end 

@(posedge hclk)
#1;
begin 
htrans = 2'd0;
end 
end
endtask

task burst_incr4_write();
begin
@(posedge hclk)
#1;
begin
hwrite=1;
htrans=2'd2;
hsize=0;
hburst=0;
hreadyin=1;
haddr=32'h8400_0000;
end
@(posedge hclk)
#1;
begin
haddr=haddr+1;
hwdata={$random}%1024;
htrans=2'd3;
end
for(i=0;i<2;i=i+1)
begin
@(posedge hclk);
#1;
begin
haddr=haddr+1;
hwdata={$random}%1024;
htrans=2'd3;
end
end
@(posedge hclk)
#1;
begin
hwdata={$random}%1024;
htrans=2'd0;
end
end
endtask
task burst_incr4_read();
begin
@(posedge hclk)
#1;
begin
hwrite=0;
htrans=2'd2;
hsize=0;
hburst=0;
hreadyin=1;
haddr=32'h8400_0000;
end
for(i=0;i<3;i=i+1)
begin
@(posedge hclk);
#1;
begin
haddr=haddr+1;
htrans=2'd3;
end
@(posedge hclk);
end
end
endtask



endmodule
