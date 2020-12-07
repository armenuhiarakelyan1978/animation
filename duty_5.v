`include "tim.v"
module duty_5(output  reg  [3:0]duty_cycle,
	output reg ready,
	output reg ready_d,
	input clk,
	input rst,
	input start_up,
        input down);

reg start_up_r;
reg down_r;
reg [8:0]cnt;
reg en;
reg en1;
reg a;

reg trig;
reg [6:0]load;
wire  out_pulse;

reg trig1;
reg [13:0]load1;
wire out_pulse1;


reg trig2;
reg [8:0]load2;
wire out_pulse2;


tim #9 t3(.clk(clk), .rst(rst),
	.trig(trig2),.load(load2), .outpulse(out_pulse2));


tim #7 t1(.clk(clk), .rst(rst),
	.trig(trig),.load(load), .outpulse(out_pulse));

tim #14 t2(.clk(clk), .rst(rst),
	.trig(trig1),.load(load1), .outpulse(out_pulse1));

always@(posedge clk)
begin
if( en == 1 && rst == 0 )begin

	trig  <= 0;
	trig1 <= 0;
        ready <= 0;
 
	       	if(out_pulse == 1 )begin
		if(duty_cycle <=9)begin
		duty_cycle <= duty_cycle + 4'b1;
		trig   <= 1;
		trig1  <= 1; 
	        end  
	        end
                if(out_pulse1 == 1 )begin
		if(duty_cycle == 10)begin
                    trig  <= 1;
		    en <= 0;
		    duty_cycle <= 0;
		    ready <= 1;
	         end
	         end
end
else 
       	
	if(en1 == 1  && rst == 0 )begin
		trig2 <= 0;		
		ready_d <= 0;
		
		if(duty_cycle != 0 && out_pulse2 == 1)begin
			trig2 <= 1;
			duty_cycle <= duty_cycle - 1;
			if(duty_cycle == 1)begin
				trig2 <= 1;
				en1 <= 0;
				ready_d <= 1;
			end
		end
	end        

else
begin
	duty_cycle <= 4'd0;
        trig  <= 1;
        trig1 <= 1;
	trig2 <= 1;
	ready <= 0;
	ready_d <=0;
end
end

always@(posedge clk or posedge rst)
	if(rst)begin
		load  = 70;
		load1 = 1776;
		load2 = 175;
	end

always@(posedge clk or posedge rst)
	if(rst)begin
		start_up_r <= 0;
		down_r <= 0;
	end
	else begin
		start_up_r <= start_up;
		down_r <= down;
	end
always@(posedge clk or posedge rst)
	if(rst)begin
            en <= 0;
	    en1 <=0;
	end
	else if(start_up & ~start_up_r)begin
		en <= 1;
	end else if (down & ~down_r)begin
		en1 <= 1;
		duty_cycle <= 10;
	end
endmodule
