`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.12.2019 19:12:41
// Design Name: 
// Module Name: Part3
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


module Part3( input clk,sw,reg [7:0][7:0]data_in,output logic[7:0][7:0]data_out);
    int row = 8;
    int column = 8;
    reg [7:0][7:0] tmp;
    always_comb
    for(int i = 0;i < row;i = i+1)
        for(int j = 0; j<column; j = j+1)
            tmp[i][j]  = data_in[i][j];
    always @ (posedge clk)
    begin
    if(tmp[row-6][column-6])
    tmp[row-6][column-6] = 1'b0;
    end
    assign data_out = tmp;
endmodule
