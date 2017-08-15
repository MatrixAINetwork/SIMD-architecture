module FetchToDecode(	
					input reset,
					input clk,
					
					input [`NUM_WARP_LOG-1:0] instWarp_i,
					input instPacket0Valid_i,
					input [`SIZE_INSTRUCTION+`SIZE_PC-1:0] instPacket0_i,
					input instPacket1Valid_i,
					input [`SIZE_INSTRUCTION+`SIZE_PC-1:0] instPacket1_i,
					
					input flush_i,
					input [`NUM_WARP_LOG-1:0] flushWarp_i,
					input stall_i,
					
					output reg [`NUM_WARP_LOG-1:0] instWarp_o,
					output reg instPacket0Valid_o,
					output reg [`SIZE_INSTRUCTION+`SIZE_PC-1:0] instPacket0_o,
					output reg instPacket1Valid_o,
					output reg [`SIZE_INSTRUCTION+`SIZE_PC-1:0] instPacket1_o
					);
					
	wire flushSame;
	assign flushSame = (flushWarp_i == instWarp_i)? 1'b1:1'b0;
	
	always @(posedge clk) begin
		if(reset) begin
			instWarp_o       <= 0;
			instPacket0Valid_o <= 0;
			instPacket0_o  	<= 0;
			instPacket1Valid_o <= 0;
			instPacket1_o    <= 0;
		end
		else begin
			if(~stall_i) begin
				if(flush_i&&flushSame) begin
					instWarp_o       <= 0;
					instPacket0Valid_o <= 0;
					instPacket0_o  	<= 0;
					instPacket1Valid_o <= 0;
					instPacket1_o    <= 0;
				end
				else begin
					instWarp_o       <= instWarp_i;
					instPacket0Valid_o <= instPacket0Valid_i;
					instPacket0_o  	<= instPacket0_i;
					instPacket1Valid_o <= instPacket1Valid_i;
					instPacket1_o    <= instPacket1_i;
				end
			end
		end	
	end
	
endmodule
