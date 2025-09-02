`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/28/2025 09:21:27 PM
// Design Name: 
// Module Name: apb_slave
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



//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/28/2025 04:13:54 PM
// Design Name: 
// Module Name: spb_slave
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

module spb_slave(
input pwrite,psel,penable,pclk,preset,
input [31:0]paddr,pwdata,
output reg pready,
output  [31:0] ppwdata);

reg [31:0]addr;
reg [31:0]mem[0:31];

assign ppwdata=mem[paddr[4:0]];

always @(posedge pclk)begin
if(~preset)begin
pready=0;

 end
else begin
addr=paddr;
  mem[paddr]=pwdata;

//slaverr<=0;

/*pready<=1;
end
end

always @(posedge pclk)begin
addr<=paddr;
if(psel && ~penable && ~pwrite) begin
pready=0;
end
else if (psel && penable && ~pwrite)begin
pready=1;    else
//            pready=0;
end*/
if (psel && ~penable && pwrite)begin
   pready=0;
   end
  if (psel && penable && pwrite)begin
        pready=1;
      
      end
//     
end
end
endmodule

