`timescale 1ns/1ns

module key(
    input CLK_50M,
    input RST_n,
    input [2:0] KEY,
    output reg [3:0] LED
);

//计数器
reg [19:0]count;
always @(posedge CLK_50M or negedge RST_n) begin
    if(!RST_n)  count<=20'd0;
    else if(count==20'd999_999) begin count<=20'd0; end
    else count<=count+1'b1;
end

//按键值锁存一个周期
reg [2:0] KEY_stay0,KEY_stay1;
always @(posedge CLK_50M or negedge RST_n) begin
    if(!RST_n)  begin KEY_stay0 <=3'b111;KEY_stay1<=3'b111; end
	 else if(count==20'd999_999) begin KEY_stay1<=KEY; end
    else KEY_stay0<=KEY_stay1;
end


//寄存器flag表示按键变化
wire [2:0] flag=KEY_stay0[2:0]&~KEY_stay1[2:0];
//按键值处理改变LED
always @(posedge CLK_50M or negedge RST_n) begin
    if(!RST_n)  LED<=4'b0001;
    else begin
        case(flag)
            3'b001: //KEY0按下
            LED<={LED[2:1],LED[0],LED[3]};
            3'b010: //KEY1按下	
				LED<={LED[0],LED[3:1]};
            3'b100: //KEY2按下
            LED<= ~LED;
            default:
				LED<=LED;
        endcase
    end
end

endmodule
