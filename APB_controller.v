`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:  Deep Dyotak Dash
// 
// Create Date: 03.09.2025 21:56:14
// Design Name: 
// Module Name: APB_controller
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


module APB_controller(input hclk,hresetn,hwrite,valid,hwritereg,
input [31:0] haddr,haddr1,haddr2,hwdata,hwdata1,hwdata2,prdata,
input [2:0] tempselx,
output reg pwrite,penable,hreadyout,
output reg [2:0] pselx,
output reg [31:0] pwdata,paddr);
reg [2:0] PS,NS;
parameter st_idle = 3'b000;
parameter st_wwait = 3'b001;
parameter st_writep= 3'b010;
parameter st_write = 3'b011;
parameter st_wenable= 3'b100;
parameter st_wenablep= 3'b101;
parameter st_read = 3'b110;
parameter st_renable = 3'b111;
//temporary o/p variables
reg penable_temp,pwrite_temp,hreadyout_temp;
reg [2:0]psel_temp;
reg [31:0]paddr_temp,pwdata_temp;
// Present state logic
always@(posedge hclk) begin
  if(!hresetn) PS <= st_idle;
  else PS <= NS;
  end
//Next state logic
always@(*) begin  
  case(PS)
    st_idle : begin 
      if(valid && hwrite) NS<=st_wwait;
      else if(valid && ~hwrite) NS<=st_read;
      else if(valid==0) NS<=st_idle;
      end
    st_wwait : begin
      if(valid) NS<=st_writep;
      else if(~valid) NS<=st_write;
      end
    st_writep : begin
      NS <= st_wenablep;
      end
    st_wenablep : begin
      if(~valid && hwritereg) NS<=st_write;
      else if(~hwritereg) NS<=st_read;
      end
    st_write : begin
      if(valid) NS<= st_wenablep;
      else if(~valid) NS<= st_wenable;
      end
    st_wenable : begin
      if(valid && hwrite) NS<=st_wwait;
      else if(valid && ~hwrite) NS<=st_read;
      else if(~valid) NS<= st_idle;
      end
    st_read : begin
      NS <= st_renable;
      end
    st_renable : begin
      if(valid && hwrite) NS<=st_wwait;
      else if(valid && ~hwrite) NS<=st_read;
      else if(~valid) NS<= st_idle;
      end
    default: begin 
      NS <= st_idle;
      end
    endcase
  end
  
//OUTPUT LOGIC
always@(*) begin
  case(PS)
    st_idle: begin 
      if(valid && hwrite) begin//burst write
        psel_temp = 3'b0;
        penable_temp = 0;
        hreadyout_temp = 1;
        end
        
      else if(valid && hwrite)  begin // Burst read
        paddr_temp = haddr; 
        psel_temp = tempselx;
        penable_temp = 0;
        pwrite_temp = 0;
        hreadyout_temp = 0;
        end
      else begin
        psel_temp=0;
        penable_temp=0;
        hreadyout_temp=1;
        end
      end
      st_read: begin 
        penable_temp = 1;
        hreadyout_temp=1;
      end
      st_renable: begin
        if(valid && hwrite) begin 
          psel_temp=0;
          penable_temp=0;
          hreadyout_temp=1;
          end
        else if (valid && hwrite == 0)
          begin
          paddr_temp=haddr;
          pwrite_temp=hwrite;
          psel_temp=tempselx;
          penable_temp=0;
          hreadyout_temp=0;
          end
        else
          begin
            psel_temp=0;
            penable_temp=0;
            hreadyout_temp=1;
            end
          end
      st_wwait: begin 
        paddr_temp=haddr1;
        pwdata_temp=hwdata;
        pwrite_temp=hwrite;
        psel_temp=tempselx;
        penable_temp=0;
        hreadyout_temp=0;
        end
      st_write:begin
        penable_temp=1;
        hreadyout_temp=1;
        end
      st_wenable:begin
        if(valid==1&&hwrite==0) begin
           hreadyout_temp=1;
           psel_temp=0;
           penable_temp=0;
           end
           else if(valid==1&&hwrite==0)begin
             paddr_temp=haddr1;
             pwrite_temp=hwritereg;
             psel_temp=tempselx;
             penable_temp=0;
             hreadyout_temp=0;
            end
            else begin
             hreadyout_temp=1;
             psel_temp=0;
             penable_temp=0;
             end
             end
      st_writep:begin
        penable_temp=1;
        hreadyout_temp=1;
        end
      st_wenablep:begin
        paddr_temp=haddr1;
        pwdata_temp=hwdata;
        pwrite_temp=hwrite;
        psel_temp=tempselx;
        penable_temp=0;
        hreadyout_temp=0;
        end
        endcase
        end
//output logic: sequential
always@(posedge hclk) begin
if(~hresetn) begin
paddr <=0;
pwdata <=0;
pwrite <=0;
pselx <= 0;
penable <= 0;
hreadyout <= 1;
end
else begin
paddr <= paddr_temp;
pwdata <=pwdata_temp;
pwrite <=pwrite_temp;
pselx<= psel_temp;
penable <= penable_temp;
hreadyout <= hreadyout_temp;
end
end
endmodule
