`include "tim.v"
module duty(output  reg [3:0]duty_cycle,
	input clk,
	input rst,
	input en);

reg duty_state;
reg [8:0]cnt;

reg trig;
reg [6:0]load;
wire  out_pulse;

reg trig1;
reg [9:0]load1;
wire out_pulse1;

tim #7 tt(.clk(clk), .rst(rst),
	.trig(trig),.load(load), .outpulse(out_pulse));

tim #10 t1(.clk(clk), .rst(rst),
	.trig(trig1),.load(load1), .outpulse(out_pulse1));

always@(posedge clk)
begin
if(en == 1 && rst == 0 && duty_cycle <= 10 )begin
	
	if(duty_state) begin
	       	if( duty_cycle <10 && out_pulse == 1)begin
		duty_cycle <= duty_cycle + 4'b1;
	        end 
                if(duty_cycle == 4'd10 && out_pulse1 == 1 )begin
		duty_state <= 1'b0;
	        end 
	        end

	else if(duty_state==1'b0 && out_pulse == 1)	
	begin
		duty_cycle = duty_cycle - 4'd1;
		if (duty_cycle == 4'd0)begin
		    duty_state <= 1'b1;
		end 
	end
        end
	else
	begin
		duty_cycle <= 4'd0;
		duty_state <= 1'b1;	
	end
end
always@(posedge clk or posedge rst)
	if(rst)begin
		trig  = 0;
		load  = 0;
		trig1 = 0;
		load1 = 0;
	end
	else begin
		trig  = 1;
		load  = 70;
		trig1 = 1;
		load1 = 320;
		if(cnt == 5)begin
			trig  = 0;
			trig1 = 0;	
		end
	end
always@(posedge clk or posedge rst)
	if(cnt < 6)
		cnt <= cnt + 1;
	else 
		cnt = 0;

endmodule
