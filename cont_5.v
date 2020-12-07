`include "duty_5.v"
`include "pwm.v"

module cont_5(
output clk_out,
output ready,
output ready_d,
input clk,
input rst,
input start_up,
input down);

wire [3:0]duty_cycle;
wire pwm_out;
wire ready1;
wire ready_d1;

duty_5 dd(.clk(clk),
.rst(rst),
.down(down),
.start_up(start_up),
.ready(ready1),
.ready_d(ready_d1),
.duty_cycle(duty_cycle));

pwm pwm_i(.clk(clk),
.rst(rst),
.duty_cycle(duty_cycle),
.pwm_out(pwm_out));

assign clk_out = pwm_out;
assign ready  =  ready1;
assign ready_d = ready_d1;


endmodule
