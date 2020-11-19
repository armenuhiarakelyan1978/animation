//`include "cont.v"
module stm2
#(parameter N = 4)
(output  [7:0] out,
	input clk,
	input rst,
	input en
);

reg [7:0] m_out;
reg [7:0] out_r;
reg en1;
reg [2:0] state, next_state;
reg [8:0] cnt; 

localparam S0 = 3'b000;
localparam S1 = 3'b001;
localparam S2 = 3'b010;
localparam S3 = 3'b011;
localparam S4 = 3'b100;
localparam S5 = 3'b101;
localparam S6 = 3'b110;
localparam S7 = 3'b111;

cont controler(.clk(clk), .rst(rst), .en(en1),.clk_out(clk_out));

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
		end
		S1:begin
			out_r = 8'b00000010;
		end
		S2:begin
			out_r = 8'b00000100;
		end
		S3:begin
			out_r = 8'b00001000;
		end
		S4:begin
			out_r = 8'b00010000;
		end
		S5:begin
			out_r = 8'b00100000;
		end
		S6:begin
			out_r = 8'b01000000;
		end
		S7:begin
			out_r = 8'b10000000;
		end
		default:begin
			out_r = 8'b00000000;
		end
	endcase
end

always@(*)
begin
	case(state)

		S0:begin
			if(clk_out== 9'd0 && cnt == 460)begin
				next_state = S1;
			end
			else begin
				next_state = S0;
			end
		end
		S1:begin
			if(clk_out == 9'd0 && cnt == 460)begin
				next_state = S2;
			end
			else begin
				next_state = S1;
			end
		end
		S2:begin
			if(clk_out == 9'd0 && cnt == 460 )begin
				next_state = S3;
			end
			else begin
				next_state = S2;
			end
		end
		S3:begin
			if(clk_out == 9'd0 && cnt == 460)begin
				next_state = S4;
			end
			else begin
				next_state = S3;
			end
		end
		S4:begin
			if(clk_out == 9'd0 && cnt == 460)begin
				next_state = S5;
			end
			else begin
				next_state = S4;
			end
		end
		S5:begin
			if(clk_out == 9'd0 && cnt == 460 )begin
				next_state = S6;
			end
			else begin
				next_state = S5;
			end
		end

		S6:begin
			if(clk_out == 9'd0 && cnt == 460)begin
				next_state = S7;
			end
			else begin
				next_state = S6;
			end
		end

		S7:begin
			if(clk_out == 9'd0 && cnt == 460 )begin
				next_state = S0;
			end
			else begin
				next_state = S7;
			end
		end
	endcase
end

always@(*)
begin
	if(rst)begin
		en1= 0;	

	end 
	else  if (state == S0 || state == S1 || state == S2 
		|| state == S3 || state == S4 || state == S5
	|| state == S6 || state == S7) begin 
	en1 = 1;

	if(cnt == 9'd461)begin
		cnt = 9'd0;
		en1 = 1'b0;
	end
end
end
always@(posedge clk)
begin
	if(cnt < 9'd461)begin
		cnt <= cnt + 9'd1;
	end
	else begin
		cnt <=9'd0;
	end
end
assign out = en ? m_out : 8'bx;
always@(*)
	case(state)
		S0:     m_out ={out_r[7:1] ,clk_out};
		S1:     m_out ={{out_r[7:2],clk_out}, out_r[0]};
		S2:     m_out ={{out_r[7:3],clk_out},out_r[1:0]};
		S3:     m_out ={{out_r[7:4],clk_out},out_r[2:0]};
		S4:     m_out ={{out_r[7:5],clk_out},out_r[3:0]};
		S5:     m_out ={{out_r[7:6],clk_out},out_r[4:0]};
		S6:     m_out ={{out_r[7],clk_out},out_r[5:0]};
		S7:     m_out = {clk_out,out_r[6:0]};
	endcase
	endmodule
