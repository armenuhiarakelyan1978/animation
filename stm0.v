//`include "tim.v"

module stm0
#(parameter N = 4)
(output reg [7:0] out,
	input clk,
	input rst
);
reg [2:0] state, next_state;
reg trig;
reg [N-1:0] load;
wire outpulse;
reg [4:0]cnt;

localparam S0 = 3'b000;
localparam S1 = 3'b001;
localparam S2 = 3'b010;
localparam S3 = 3'b011;
localparam S4 = 3'b100;
localparam S5 = 3'b101;
localparam S6 = 3'b110;
localparam S7 = 3'b111;

tim #(N) delay(.load(load),.clk(clk),.rst(rst),
	.trig(trig), .outpulse(outpulse));

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
			out = 8'b00000001;
		end
		S1:begin
			out = 8'b00000010;
		end
		S2:begin
			out = 8'b00000100; 
		end
		S3:begin
			out = 8'b00001000;
		end
		S4:begin
			out = 8'b00010000;
		end
		S5:begin
			out = 8'b00100000;
		end
		S6:begin
			out = 8'b01000000;
		end
		S7:begin
			out = 8'b10000000;
		end
		default:begin
			out = 8'b00000000;
		end
	endcase
end

always@(*)
begin
	case(state)

		S0:begin
			if(outpulse == 8'b1)begin
				next_state = S1;
			end
			else begin
				next_state = S0;
			end
		end
		S1:begin
			if(outpulse == 8'b1)begin
				next_state = S2;
			end
			else begin
				next_state = S1;
			end
		end
		S2:begin
			if(outpulse == 8'b1)begin
				next_state = S3;
			end
			else begin
				next_state = S2;
			end
		end
		S3:begin
			if(outpulse == 8'b1)begin
				next_state = S4;
			end
			else begin
				next_state = S3;
			end
		end
		S4:begin
			if(outpulse == 8'b1)begin
				next_state = S5;
			end
			else begin
				next_state = S4;
			end
		end
		S5:begin
			if(outpulse == 8'b1)begin
				next_state = S6;
			end
			else begin
				next_state = S5;
			end
		end

		S6:begin
			if(outpulse == 8'b1)begin
				next_state = S7;
			end
			else begin
				next_state = S6;
			end
		end

		S7:begin
			if(outpulse == 8'b1 )begin
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
		trig = 1'b0;
		load = 4'b0;
	end 
	else  if (state == S0 || state == S1 || state == S2 
		|| state == S3 || state == S4 || state == S5
	|| state == S6 || state == S7) begin 
	trig = 1'b1;
	load = 4'd15;
	if(cnt == 4'd13 )begin
		cnt = 4'd0;
		trig =1'b0;
	end
	end
end
always@(posedge clk or rst)
	if(cnt < 4'd14)begin
		cnt <= cnt + 4'd1;
	end
	else begin
		cnt <= 4'd0;
	end

endmodule
