`include "cont_5.v"

module stm4
#(parameter N = 4)
(output  [7:0] out,
	input clk,
	input rst
);

reg [3:0] state, next_state;
reg en;
reg start_up;
reg down;
reg [3:0] cnt;
reg [13:0] cnt1;
reg [7:0] m_out;
reg [7:0] out_r;
wire ready_d;
wire ready;
reg a;

localparam S0  = 4'b0000;
localparam S1  = 4'b0001;
localparam S2  = 4'b0010;
localparam S3  = 4'b0011;
localparam S4  = 4'b0100;
localparam S5  = 4'b0101;
localparam S6  = 4'b0110;
localparam S7  = 4'b0111;
localparam S8  = 4'b1000;
localparam S9  = 4'b1001;
localparam S10 = 4'b1010;
localparam S11 = 4'b1011;
localparam S12 = 4'b1100;
localparam S13 = 4'b1101;
localparam S14 = 4'b1110;
localparam S15 = 4'b1111;

cont_5 control(.clk(clk),
	.rst(rst),.clk_out(clk_out), 
	.start_up(start_up),
	.down(down),.ready(ready),
	.ready_d(ready_d));


always@(posedge clk or posedge rst )
begin
	if(rst)begin
		state <= S0;
	end
	else begin
		state <= next_state;
	end
end

always@(state)
begin
	case(state)

		S0:begin
			out_r = 8'b00000001;
			en = 1'b1;
		end

		S1:begin
			out_r = 8'b00000011;
			en = 1'b1;
		end
		S2:begin
			out_r = 8'b00000111;

			en = 1'b1;
		end
		S3:begin
			out_r = 8'b00001111;

			en = 1'b1;
		end
		S4:begin
			out_r = 8'b00011111;

			en = 1'b1;
		end
		S5:begin
			out_r = 8'b00111111;

			en = 1'b1;
		end
		S6:begin
			out_r = 8'b01111111;
			en = 1'b1;
		end
		S7:begin
			out_r = 8'b11111111;
			en = 1'b1;
		end
		S8:begin
			out_r = 8'b01111111;
			en = 1'b1;
		end

		S9:begin
			out_r = 8'b00111111;

			en = 1'b1;
		end
		S10:begin
			out_r = 8'b00011111;

			en = 1'b1;
		end
		S11:begin
			out_r = 8'b00001111;

			en = 1'b1;
		end
		S12:begin
			out_r = 8'b00000111;

			en = 1'b1;
		end
		S13:begin
			out_r = 8'b00000011;

			en = 1'b1;
		end
		S14:begin
			out_r = 8'b00000001;

			en = 1'b1;
		end
		S15:begin
			out_r = 8'b00000000;

			en = 1'b1;
		end
	endcase
end

always@(*)
begin
	case(state)

		S0:begin
			if(ready == 1)begin
				next_state = S1;
			end
			else begin
				next_state = S0;
			end
		end
		S1:begin
			if(ready == 1)begin
				next_state = S2;
			end
			else begin
				next_state = S1;
			end
		end
		S2:begin
			if(ready == 1 )begin
				next_state = S3;
			end
			else begin
				next_state = S2;
			end
		end
		S3:begin
			if(ready == 1)begin
				next_state = S4;
			end
			else begin
				next_state = S3;
			end
		end
		S4:begin
			if(ready == 1)begin
				next_state = S5;
			end
			else begin
				next_state = S4;
			end
		end
		S5:begin
			if(ready == 1)begin
				next_state = S6;
			end
			else begin
				next_state = S5;
			end
		end

		S6:begin
			if(ready == 1)begin
				next_state = S7;
			end
			else begin
				next_state = S6;
			end
		end

		S7:begin
			if(ready == 1 )begin
				next_state = S8;
			end
			else begin
				next_state = S7;
			end
		end

		S8:begin
			if(ready_d == 1)begin
				next_state = S9;
			end
			else begin
				next_state = S8;
			end
		end
		S9:begin
			if(ready_d == 1)begin
				next_state = S10;
			end
			else begin
				next_state = S9;
			end
		end
		S10:begin
			if(ready_d == 1)begin
				next_state = S11;
			end
			else begin
				next_state = S10;
			end
		end
		S11:begin
			if(ready_d == 1)begin
				next_state = S12;
			end
			else begin
				next_state = S11;
			end
		end
		S12:begin
			if(ready_d == 1)begin
				next_state = S13;
			end
			else begin
				next_state = S12;
			end
		end
		S13:begin
			if(ready_d == 1)begin
				next_state = S14;
			end
			else begin
				next_state = S13;
			end
		end

		S14:begin
			if(ready_d == 1)begin
				next_state = S15;
			end
			else begin
				next_state = S14;
			end
		end
		S15:begin
			if(ready_d == 1)begin
				next_state = S0;
			end
			else begin
				next_state = S15;
			end
		end	
	endcase
end

always@(*)
begin


	if(rst)begin
		start_up = 0;
		down =0;
		a = 1;
	end 
	else if(state == S0 || state == S1 || state == S2
		|| state == S3 || state == S4 || state == S5
	|| state == S6 || state == S7 ) begin
		start_up = 1'b1;
		if(cnt == 10)begin
			start_up  = 1'b0;
		end
	end

	else if(state == S8  || state == S9 || state == S10
		|| state == S11 || state == S12 || state == S13
	|| state == S14 || state == S15 ) begin
		start_up = 1'b0;     
		down  = 1'b1;
		if(cnt1 == 14'd2285)begin
			down  = 14'b0;
		end
	end
end
always@(posedge clk  )
begin
	if(cnt < 4'd11)begin
		cnt <= cnt + 2'd1;
	end
	else begin
		cnt <= 2'b0;
	end
end

always@(posedge clk)
begin
	if(cnt1 <14'd2300)begin
		cnt1 <= cnt1 + 14'b1;
	end
	else begin
		cnt1 <= 0;
	end
end

assign out = en ? m_out :16'd0;
always@(*)
	case(state)
		S0: m_out = {out_r[7:1],clk_out};
		S1: m_out = {{out_r[7:2],clk_out},a};
		S2: m_out = {{out_r[7:3],clk_out},{2{a}}};
		S3: m_out = {{out_r[7:4],clk_out},{3{a}}};
		S4: m_out = {{out_r[7:5],clk_out},{4{a}}};
		S5: m_out = {{out_r[7:6],clk_out},{5{a}}};
		S6: m_out = {{out_r[7],clk_out},{6{a}}};
		S7: m_out = {{clk_out},{7{a}}};
		S8: m_out = {{clk_out},{7{a}}};
		S9: m_out = {{out_r[7],clk_out},{6{a}}};
		S10:m_out = {{out_r[7:6],clk_out},{5{a}}};
		S11:m_out = {{out_r[7:5],clk_out},{4{a}}};
		S12:m_out = {{out_r[7:4],clk_out},{3{a}}};
		S13:m_out = {{out_r[7:3],clk_out},{2{a}}};
		S14:m_out = {{out_r[7:2],clk_out},a};
		S15:m_out = {out_r[7:1],clk_out};	
	endcase

	endmodule
