`include "cont.v"

module stm3
#(parameter N = 4)
(output  [7:0] out,
input clk,
input rst,
input en
);

reg [3:0] state, next_state;
reg en1;
reg [8:0] cnt;
reg [7:0] m_out;
reg [7:0] out_r;

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

cont control(.clk(clk),
.rst(rst),.clk_out(clk_out), .en(en1));


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
	    out_r = 8'b00000011;
    end
    S2:begin
	    out_r = 8'b00000111;
    end
    S3:begin
	    out_r = 8'b00001111;
    end
    S4:begin
	    out_r = 8'b00011111;
    end
    S5:begin
	    out_r = 8'b00111111;
    end
    S6:begin
	    out_r = 8'b01111111;
    end
    S7:begin
            out_r = 8'b11111111;
    end
    S8:begin
	    out_r = 8'b01111111;
    end
    
    S9:begin
	    out_r = 8'b00111111;
    end
    S10:begin
	    out_r = 8'b00011111;
    end
    S11:begin
	    out_r = 8'b00001111;
    end
    S12:begin
	    out_r = 8'b00000111;
    end
    S13:begin
	    out_r = 8'b00000011;
    end
    S14:begin
	    out_r = 8'b00000001;
    end
    S15:begin
	    out_r = 8'b00000000;
    end
    endcase
end

always@(*)
begin
	case(state)

		S0:begin
			if(clk_out == 9'd0 && cnt == 460)begin
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
			if(clk_out == 9'd0 && cnt == 460)begin
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
			if(clk_out == 9'd0 && cnt == 460)begin
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
			if(clk_out == 0 && cnt == 460 )begin
				next_state = S8;
			end
			else begin
				next_state = S7;
			end
		end
               
		S8:begin
			if(clk_out == 0 && cnt == 460)begin
				next_state = S9;
			end
			else begin
				next_state = S8;
			end
		end
		S9:begin
			if(clk_out == 0 && cnt == 460)begin
				next_state = S10;
			end
			else begin
				next_state = S9;
			end
		end
		S10:begin
			if(clk_out == 0 && cnt == 460)begin
				next_state = S11;
			end
			else begin
				next_state = S10;
			end
		end
		S11:begin
			if(clk_out == 0 && cnt == 460)begin
				next_state = S12;
			end
			else begin
				next_state = S11;
			end
		end
		S12:begin
			if(clk_out == 0 && cnt == 460)begin
				next_state = S13;
			end
			else begin
				next_state = S12;
			end
		end
		S13:begin
			if(clk_out == 0 && cnt == 460)begin
				next_state = S14;
			end
			else begin
				next_state = S13;
			end
		end
		
		S14:begin
			if(clk_out == 0 && cnt == 460)begin
				next_state = S15;
			end
			else begin
				next_state = S14;
			end
		end
		S15:begin
			if(clk_out == 0 && cnt == 460)begin
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
		en1 = 1'b0;
	end 
	else  if (   state == S0  || state == S1  || state == S2 
		  || state == S3  || state == S4  || state == S5
	          || state == S6  || state == S7  || state == S8
		  || state == S9  || state == S10 || state == S11
		  || state == S12 || state == S13 || state == S14
		  || state == S15  ) begin 
		en1 = 1;
		
		if(cnt == 9'd461)begin
                     cnt  = 9'b0;
		     en1  = 1'b0;
		end
	end
end
always@(posedge clk  )
begin
	if(cnt < 9'd461)begin
		cnt <= cnt + 9'd1;
	end
	else begin
		cnt <= 9'b0;
	end
end

assign out = en ? m_out :16'dx;
always@(*)
	case(state)
		S0: m_out = {out_r[7:1],clk_out};
		S1: m_out = {{out_r[7:2],clk_out},clk_out};
		S2: m_out = {{{out_r[7:3],clk_out},clk_out},clk_out};
                S3: m_out = {{{{out_r[7:4],clk_out},clk_out},clk_out},clk_out};
		S4: m_out = {{{{{out_r[7:5],clk_out},clk_out},clk_out},clk_out},clk_out};
		S5: m_out = {{{{{{out_r[7:6],clk_out},clk_out},clk_out},clk_out},clk_out},clk_out};
		S6: m_out = {{{{{{{out_r[7],clk_out},clk_out},clk_out},clk_out},clk_out},clk_out},clk_out};
		S7: m_out = {8{clk_out}};
		S8: m_out ={{out_r[7],clk_out},{6{clk_out}}};
	        S9: m_out = {{out_r[7:6],clk_out},{5{clk_out}}};
	        S10:m_out = {{out_r[7:5],clk_out},{4{clk_out}}};
	        S11:m_out = {{out_r[7:4],clk_out},{3{clk_out}}};
	        S12:m_out = {{out_r[7:3],clk_out},{2{clk_out}}};
	        S13:m_out = {{out_r[7:2],clk_out},clk_out};
	        S14:m_out = {out_r[7:1],clk_out};
	        S15:m_out = {out_r[7:0]};	
	endcase

endmodule
