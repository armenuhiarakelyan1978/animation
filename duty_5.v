//`include "tim.v"
module duty_5(output  reg  [3:0]duty_cycle,
	output reg ready,
	input clk,
	input rst,
	input start);

reg start_r;
reg [8:0]cnt;
reg en;

reg trig;
reg [6:0]load;
wire  out_pulse;

reg trig1;
reg [13:0]load1;
wire out_pulse1;


tim #7 t1(.clk(clk), .rst(rst),
	.trig(trig),.load(load), .outpulse(out_pulse));

tim #14 t2(.clk(clk), .rst(rst),
	.trig(trig1),.load(load1), .outpulse(out_pulse1));

always@(posedge clk)
begin
if( en == 1 && rst == 0  )begin

	trig  <= 0;
	trig1 <= 0;
        ready <= 0;
 
	       	if( duty_cycle <10 && out_pulse == 1 )begin
		duty_cycle <= duty_cycle + 4'b1;
		trig   <= 1;
		trig1  <= 1; 
	        end else 
                if(duty_cycle == 4'd10 && out_pulse1 == 1 )begin
                    trig  <= 1;
		    en <= 0;
		    duty_cycle <= 0;
		    ready <= 1;
	         end
end
else 
begin
	duty_cycle <= 4'd0;
        trig  <= 1;
        trig1 <= 1;
	ready <= 0;
end
end

always@(posedge clk or posedge rst)
	if(rst)begin
		load  = 70;
		load1 = 1776;
	end

always@(posedge clk or posedge rst)
	if(rst)begin
		start_r <= 0;
	end
	else begin
		start_r <= start;
	end
always@(posedge clk or posedge rst)
	if(rst)begin
            en <= 0;
	end
	else if(start & ~start_r)begin
		en <= 1;
	end
endmodule
