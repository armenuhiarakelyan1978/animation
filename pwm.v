module pwm
# (parameter DIV = 5'd20)
(
	output  pwm_out,
	input clk, rst,
	input [3:0] duty_cycle );

reg  [3:0] duty_cycle_r;
reg  [4:0] cnt;
wire [4:0] T1;

assign T1 = (DIV*duty_cycle_r)/10;

always@(posedge clk or posedge rst)
begin
	if(rst)begin
		cnt <= 5'b00000;
		duty_cycle_r <= 4'b0000;
	end
	if(cnt < DIV-1 )begin 
		cnt <= cnt +5'b00001;
	end else begin
		cnt <= 5'b00000;
		duty_cycle_r <= duty_cycle; 

	end
end

assign pwm_out =((cnt < T1)?1:0);

endmodule
