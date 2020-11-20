`include "duty.v"
`include "pwm.v"
module cont(
output clk_out,
input clk,
input rst,
input start);

wire [3:0]duty_cycle;
wire pwm_out;

duty dd(.clk(clk),
.rst(rst),
.start(start),
.duty_cycle(duty_cycle));

pwm pwm_i(.clk(clk),
.rst(rst),
.duty_cycle(duty_cycle),
.pwm_out(pwm_out));

assign clk_out = pwm_out;

endmodule
