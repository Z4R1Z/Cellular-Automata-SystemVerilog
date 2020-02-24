`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.12.2019 19:57:25
// Design Name: 
// Module Name: sad
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


module sad(
int row;
     int column;
     for(int i = 0; i < size; i = i + 1)
     begin
         row = data[i] / 8;
         column = data[i] % 8;
         if(column == 0 & row != 0)
         begin
             if((data_in[row][(column + 1) % 8] == 1) & (data_in[row][7]
== 1) & (data_in[(row + 1) % 8][column] == 1) & (data_in[(row - 1) %
8][column] == 1))
             begin
                 data_in[row][column] = 1;
             end else
             begin
                 data_in[row][column] = 0;
             end
         end else if(row == 0 & column != 0)
         begin
             if((data_in[row][(column + 1) % 8] == 1) &
(data_in[row][(column - 1) % 8 ] == 1) & (data_in[(row + 1) % 8][column]
== 1) & (data_in[7][column] == 1))
             begin
                 data_in[row][column] = 1;
             end else
             begin
                 data_in[row][column] = 0;
             end
         end else if(column == 0 & row == 0)
         begin
             if((data_in[row][(column + 1) % 8] == 1) & (data_in[row][7]
== 1) & (data_in[(row + 1) % 8][column] == 1) & (data_in[7][column] ==
1))
             begin
                 data_in[row][column] = 1;
             end else
             begin
                 data_in[row][column] = 0;
             end
         end else
         begin
             if((data_in[row][(column + 1) % 8] == 1) &
(data_in[row][(column - 1) %8 ] == 1) & (data_in[(row + 1) % 8][column]
== 1) & (data_in[(row - 1) % 8][column] == 1))
             begin
                 data_in[row][column] = 1;
             end else
             begin
                 data_in[row][column] = 0;
             end
         end
     end
     return 0;
endfunction

    );
endmodule
