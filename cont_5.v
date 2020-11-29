//`include "duty_5.v"
//`include "pwm.v"

module cont_5(
output clk_out,
output ready,
input clk,
input rst,
input start);

wire [3:0]duty_cycle;
wire pwm_out;
wire ready1;

duty_5 dd(.clk(clk),
.rst(rst),
.start(start),
.ready(ready1),
.duty_cycle(duty_cycle));

pwm pwm_i(.clk(clk),
.rst(rst),
.duty_cycle(duty_cycle),
.pwm_out(pwm_out));

assign clk_out = pwm_out;
assign ready  =  ready1;


endmodule
