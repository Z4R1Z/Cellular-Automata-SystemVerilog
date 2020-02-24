`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.12.2019 01:19:16
// Design Name: 
// Module Name: Part2
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


module Part2( input clk, assig, [1:0]select, [3:0]value1,value2,value3,value4,output reg [15:0]led, reg[63:0]Value);
    reg [63:0]theValue = 0;
    
    
    always @ (posedge clk)
    begin
        if(select == 2'b00 && assig)
        begin
            theValue[15:12] = value4;
            theValue[11:8] = value3;
            theValue[7:4] = value2;
            theValue[3:0] = value1;
            led[15:0] = theValue[15:0];
        end
        else if(select == 2'b00&& ~assig)
        led[15:0] = theValue[15:0];
        else if(select == 2'b01&& assig)
        begin
            theValue[31:28] = value4;
            theValue[27:24] = value3;
            theValue[23:20] = value2;
            theValue[19:16] = value1;
            led[15:0] = theValue[31:16];
        end
        else if(select == 2'b01&& ~assig)
        led[15:0] = theValue[31:16];
        else if(select == 2'b10&& assig)
        begin
            theValue[47:44] = value4;
            theValue[43:40] = value3;
            theValue[39:36] = value2;
            theValue[35:32] = value1;
            led[15:0] = theValue[47:32];
        end
        else if(select == 2'b10&& ~assig)
            led[15:0] = theValue[47:32];        
        else if(select == 2'b11 && assig)
        begin
            theValue[63:60] = value4;
            theValue[59:56] = value3;
            theValue[55:52] = value2;
            theValue[51:48] = value1;
            led[15:0] = theValue[63:48];
        end
        else if(select == 2'b11 && ~assig)
            led[15:0] = theValue[63:48];
    end
    assign Value = theValue;
endmodule
