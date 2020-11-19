`include "stm0.v"
`include "stm1.v"
`include "stm2.v"
`include "tim.v"
`include "cont.v"

module stm(output  [7:0] out,
	input clk,
	input rst,
	input [1:0] mode,
	input en);

wire [7:0]out_0;
wire [7:0]out_1;
wire [7:0]out_2;
reg  [7:0]m_out;
reg    en1=1;


stm0 st0(.clk(clk), .rst(rst),
	.out(out_0));

stm1 st1(.clk(clk), .rst(rst),
	.out(out_1));

stm2 st2(.clk(clk), .rst(rst),
	.out(out_2),
        .en(en1));

assign out = (en ? m_out : 8'bx);
always@(*)
	case(mode)
		00:      m_out = out_0;
		01:      m_out = out_1;
		02:      m_out = out_2;
		default: m_out = 8'bx;
	endcase
	endmodule

