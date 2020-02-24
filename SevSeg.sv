`timescale 1ns / 1ps

module SevSeg(
input clk,
input assig,
input [1:0] sw,
input [3:0] value, 
output [3:0] value1,value2,value3,value4
);


localparam N = 18;
logic [N-1:0] count = {N{1'b0}};  
always @ (posedge clk)
count <= count + 1;
logic [3:0]digit_val; 
logic [3:0]digit_en,prev1,prev2,prev3,prev4,cur1,cur2,cur3,cur4; 

always_comb
begin
if(sw[1:0] == 2'b00 && assig)
   begin
    cur2= prev2;
    cur3= prev3;
    cur4 = prev4;
    cur1 = value;
    prev1 = value;
   end
else if(sw[1:0] == 2'b01 && assig)
   begin
    cur1= prev1;
    cur3= prev3;
    cur4 = prev4;
    cur2 = value;
    prev2 = value;
   end
else if(sw[1:0] == 2'b10 && assig)
   begin
    cur2= prev2;
    cur1= prev1;
    cur4 = prev4;
    cur3 = value;
    prev3 = value;
   end
else if(sw[1:0] == 2'b11 && assig)
   begin
    cur2= prev2;
    cur3= prev3;
    cur1 = prev1;
    cur4 = value;
    prev4 = value;
   end
else
    begin 
    cur1 = prev1;
    cur2 = prev2;
    cur3 = prev3;
    cur4 = prev4;
    end
end


assign value1 = prev1;
assign value2 = prev2;
assign value3 = prev3;
assign value4 = prev4;
 //turn dp off
endmodule