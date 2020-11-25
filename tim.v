module tim
#(parameter N = 4)
(output outpulse,
	input clk,
	input rst,
	input trig,
	input [N-1:0] load);


reg [N-1:0] cnt;
reg trig_r, out_pulse, out_pulse_r;
reg  en;

always@(posedge clk or posedge rst)
	if(rst) begin
		trig_r <= 1'b0;
		out_pulse_r <= 1'b0;
		out_pulse <= 1'b0;
	end
	else	begin
		trig_r <= trig;
		out_pulse_r <= out_pulse;
	end

	always@(posedge clk or posedge rst)
	begin
		if(rst || cnt == load - 1)begin
			en <= 1'b0;
		end
		else if (~trig & trig_r) begin
			en <= 1'b1;
		end
	end

	always@(posedge clk)
	begin
		if(rst)begin
			out_pulse <= 1'b0;
		end
		else if(cnt == load - 1)begin
			out_pulse <= 1'b1;
		end
		else begin
			out_pulse <= 1'b0;
		end
	end

	always@(posedge clk or posedge rst)
	begin
		if(rst)begin
			cnt <= 4'b0;
		end
		else if(cnt == load-1 || !en )begin
			cnt <= 4'b0000;
		end
		else   begin
			cnt <= cnt + 4'b0001;
		end
	end


	assign outpulse = (out_pulse & ~out_pulse_r);
	endmodule
