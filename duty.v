module duty(output  [3:0]duty_cycle,
input clk,
input rst,
input en);

reg [3:0] duty_cycle_r;
reg [4:0] cnt;
reg [6:0] cnt1;
reg a;
always @(posedge clk or posedge rst)
begin
	if(rst || ~en)begin
		duty_cycle_r <= 0;
		cnt <= 0;
	end
	else if (en && duty_cycle_r < 10)begin
		if(cnt == 20)begin
			cnt <=0;

		duty_cycle_r <= duty_cycle_r+1;
		end
	end
	else if (duty_cycle_r==10 && cnt == 20 ) begin
		if(cnt == 20)begin
			cnt  <= 0;
		end
		a <= 1;
	end
	if  (duty_cycle_r <= 10 && a && duty_cycle_r >=1)begin
		if(cnt == 20)begin
			cnt <= 0;
			duty_cycle_r <= duty_cycle_r -1;
		end

	end
	else if (duty_cycle_r ==0 && a )begin
		a<=0;
	end

end
assign duty_cycle = duty_cycle_r;
always@(posedge clk or posedge rst)begin
	if(cnt <20)begin
		cnt <= cnt +1;
	end
	else begin
		cnt <= 0;
	end
end


endmodule
