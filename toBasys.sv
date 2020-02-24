`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.12.2019 00:06:41
// Design Name: 
// Module Name: FSM
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


module toBasys(input clk,btnU,btnC,btnL,btnR,btnD,[9:0]sw,output dp,reg [6:0]seg,[3:0]an, [15:0]LED,
output logic[7:0] rowsOut,
    output logic shcp, stcp, mr, oe, ds  );
    logic [3:0] value1,value2,value3,value4,in0 = value1,in1 = value2,in2 = value3,in3 = value4;
    logic [63:0] theValue;
    logic [7:0][7:0]data_in = theValue;
    logic leds0,leds1,leds2,leds3,leds4,leds5,leds6;
    logic but0, but1,but2,but3;
    logic [15:0]count = 16'b0;
    logic [34:0]clkcount = 35'b0;
    int grp1[15:0] = '{4, 6, 8, 10, 20, 22, 24, 26, 32, 34, 36, 38 ,48, 50, 52 ,54};
    int grp2[15:0] = '{5,7,9,11,21,23,25,27,37,39,40,42,53,55,56,58};
    int grp3[15:0] = '{0,2,13,15,16,18,29,31,41,43,45,47,57,59,61,63};
    int grp4[15:0] = '{1,3,12,14,17,19,28,30,33,35,44,46,49,51,60,62};
    
    typedef enum logic [1:0] {S0,S1,S2,S3} statetype; 

    statetype[1:0] state, nextState; 
    
    SevSeg alk(clk,sw[6],sw[1:0],sw[5:2], value1[3:0],value2[3:0],value3[3:0],value4[3:0]);
    Part2 aki(clk,sw[6],sw[8:7],value1[3:0],value2[3:0],value3[3:0],value4[3:0],LED[15:0],theValue);
    
    Score a(clk,in0,in1,in2,in3,leds0,leds1,leds2,leds3,leds4,leds5,leds6,dp,an);
   
    always_ff @(posedge clk) 

    if(sw[9]) state <= S0; 

    else state <= nextState;
    
    always_comb
    begin 
    
    case(state)
        S0:  if(btnC)   nextState = S1;
             else       nextState = S0;
        S1:  if(sw[9])   nextState = S0;
             else if(data_in == 0)  nextState = S2;
             else nextState = S1;
        S2:  if(btnC)   nextState = S1;
             else if(sw[9])   nextState = S0;
             else   nextState = S2;
        default :   nextState = S0;
        endcase          
    end
    
    always @ (posedge clk)
    begin
        if(state == S0)
        begin
        seg[0] = leds0;
        seg[1] = leds1;
        seg[2] = leds2;
        seg[3] = leds3;
        seg[4] = leds4;
        seg[5] = leds5;
        seg[6] = leds6;
        data_in = theValue;
        in0 = value1;
        in1 = value2;
        in2 = value3;
        in3 = value4;    
        end
        else if(state == S1)
        begin
        seg[0] = leds0;
        seg[1] = leds1;
        seg[2] = leds2;
        seg[3] = leds3;
        seg[4] = leds4;
        seg[5] = leds5;
        seg[6] = leds6;
            if(btnC)
            begin
            data_in = theValue;
            count = 0;
            end
            but0 <= btnU;
            if(btnU && ~but0)
                 begin
                 rule(grp1);
                 count = count +1;
                 end
            but1 <= btnD;
            if(btnD && ~but1)
                begin
                rule(grp2);
                count = count +1;
                end
            but2 <= btnL;
            if(btnL && ~but2)
                begin
                rule(grp3);
                count = count +1;
                end
            but3 <= btnR;
            if(btnR && ~but3)
                begin
                rule(grp4);
                count = count +1;
                end
            in0 = count%10;
            in1 = (count/10)%10;
            in2 = (count/100)%10;
            in3 = (count/1000)%10;
        end
        else if(state == S2)
        begin
            seg[0] = 1;
            seg[1] = 1;
            seg[2] = 1;
            seg[3] = 1;
            seg[4] = 1;
            seg[5] = 1;
            seg[6] = 1;
            
            
            clkcount = clkcount +1;
            if(clkcount >= 25000000)
            begin
                   seg[0] = leds0;
                   seg[1] = leds1;
                   seg[2] = leds2;
                   seg[3] = leds3;
                   seg[4] = leds4;
                   seg[5] = leds5;
                   seg[6] = leds6;
                    if(clkcount >= 50000000)
                    clkcount = 0;
            end 
        end
    end        
         
function automatic int rule (input int group[15:0]);
        int row = 0, col = 0;
        for (int i = 0; i < 16; i = i+1)
        begin
            row = group[i]/8;
            col = group[i]%8;
              
                  if(data_in[(row+1) % 8][col] && data_in[row][(col+1) % 8]&& data_in[row][(col-1) % 8]&& ~data_in[(row-1) % 8][col])
                      data_in[row][col] = 1;
                  else if(data_in[(row+1) % 8][col] && ~data_in[row][(col+1) % 8]&& data_in[row][(col-1) % 8]&& ~data_in[(row-1) % 8][col])
                       data_in[row][col] = 1;
                  else if(data_in[(row+1) % 8][col] && data_in[row][(col+1) % 8]&& ~data_in[row][(col-1) % 8]&& data_in[(row-1) % 8][col])        
                       data_in[row][col] = 1;
                  else if(data_in[(row+1) % 8][col] && data_in[row][(col+1) % 8]&& ~data_in[row][(col-1) % 8]&& ~data_in[(row-1) % 8][col])
                       data_in[row][col] = 1;
                  else if(data_in[(row+1) % 8][col] && ~data_in[row][(col+1) % 8]&& ~data_in[row][(col-1) % 8]&& data_in[(row-1) % 8][col])    
                       data_in[row][col] = 1;
                  else if(~data_in[(row+1) % 8][col] && data_in[row][(col+1) % 8]&& data_in[row][(col-1) % 8]&& data_in[(row-1) % 8][col])
                       data_in[row][col] = 1;
                  else if(~data_in[(row+1) % 8][col] && data_in[row][(col+1) % 8]&& ~data_in[row][(col-1) % 8]&& ~data_in[(row-1) % 8][col])
                       data_in[row][col] = 1;
                  else
                       data_in[row][col] = 0;
            
            
        end
    return 0;
endfunction

convert conv(clk, data_in, rowsOut,shcp, stcp, mr, oe, ds );

endmodule