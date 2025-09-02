`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/28/2025 09:12:38 PM
// Design Name: 
// Module Name: apb_master
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


module apb_master(
//module apb_protocol(
output reg pwrite,psel,penable,
output reg [31:0]paddr,pwdata,
input [31:0]SWDATA,SADDR,
input preset,pclk,swrite,ptransfer,pready
);
    
//reg ptransfer;
//reg penable;
//reg [31:0]paddr;
//reg [31:0]pwdata;
//reg pready;
//reg pwrite;

reg [1:0]state,nextstate;
parameter idle=2'b00,setup=2'b01,access=2'b10;

always @(posedge pclk)begin
if(!preset)begin
state<=idle;
psel<=0;
//ptransfer<=0;
penable<=0;
pwdata<=32'h0;
paddr<=32'h0;
end 
else begin
state<=nextstate;
end
end

always @(*)begin
case (state)
//Idle State
 idle:begin
      psel=0;
        penable=0;
    if(ptransfer)begin
      
        nextstate=setup;
        end 
    else begin
      nextstate=idle;
    end 
 end
 
 //Setup State
 setup:begin
       penable=0;
       psel=1;
       pwrite=swrite;
       paddr=SADDR;
       pwdata=SWDATA;
 nextstate=access;
 end
//Access State
 access:begin 
        penable=1;
        if( pready)begin
           paddr=SADDR;
           pwdata=SWDATA;
             if(ptransfer)begin  
                nextstate=setup;
             end
             else
               nextstate=idle;
        end
        else begin
               nextstate=access;
        end
  end
endcase
end
endmodule


