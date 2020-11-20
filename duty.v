`include "tim.v"
module duty(output  reg [3:0]duty_cycle,
	input clk,
	input rst,
	input start);

reg duty_state;
reg start_r;
reg [8:0]cnt;
reg en;

reg trig;
reg [6:0]load;
wire  out_pulse;

reg trig1;
reg [9:0]load1;
wire out_pulse1;

tim #7 t1(.clk(clk), .rst(rst),
	.trig(trig),.load(load), .outpulse(out_pulse));

tim #10 t2(.clk(clk), .rst(rst),
	.trig(trig1),.load(load1), .outpulse(out_pulse1));

always@(posedge clk)
begin
if( en == 1 && rst == 0 && duty_cycle <= 10 )begin

	trig  <= 0;
	trig1 <= 0;
	
	if(duty_state) begin
	       	if( duty_cycle <10 && out_pulse == 1)begin
		duty_cycle <= duty_cycle + 4'b1;
		trig   <= 1;
		trig1  <= 1; 
	        end
                if(duty_cycle == 4'd10 && out_pulse1 == 1 )begin
		duty_state <= 1'b0;
		trig  <= 1;
	        end 
         end

	else if(duty_state==1'b0 && out_pulse == 1)	
	begin
		trig <= 1;
		duty_cycle <= duty_cycle - 4'd1;
		if (duty_cycle == 4'd0)begin
		    duty_state <= 1'b1;
		    en <= 0;
		end 
	end
end
else 
begin
	duty_cycle <= 4'd0;
	duty_state <= 1'b1;
        trig  <= 1;
        trig1 <= 1;	
end
end

always@(posedge clk or posedge rst)
	if(rst)begin
		load  = 70;
		load1 = 320;
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
