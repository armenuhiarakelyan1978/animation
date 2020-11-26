`include "stm0.v"
`include "stm1.v"
`include "stm2.v"
`include "stm3.v"
`include "tim.v"
`include "duty.v"
`include "cont.v"
`include "pwm.v"

module stm(output  [7:0] out,
	input clk,
	input rst,
	input [1:0] mode,
	input en);

wire [7:0]out_0;
wire [7:0]out_1;
wire [7:0]out_2;
wire [7:0]out_3;
reg  [7:0]m_out;


stm0 st0(.clk(clk), .rst(rst),
	.out(out_0));

stm1 st1(.clk(clk), .rst(rst),
	.out(out_1));

stm2 st2(.clk(clk), .rst(rst),
	.out(out_2) );

stm3 st3(.clk(clk), .rst(rst),
	.out(out_3));


assign out = (en ? m_out : 8'd0);

always@(*)
	case(mode)
		00:      m_out = out_0;
		01:      m_out = out_1;
		10:      m_out = out_2;
		11:      m_out = out_3;
	endcase
	endmodule

