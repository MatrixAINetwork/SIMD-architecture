module Decode(	input reset,
                input clk,
				
				input [`NUM_WARP_LOG-1:0] instWarp_i,
				input instPacket0Valid_i,
				input [`SIZE_INSTRUCTION+`SIZE_PC-1:0] instPachet0_i,
				input instPacket1Valid_i,
				input [`SIZE_INSTRUCTION+`SIZE_PC-1:0] instPachet1_i,
				
				output [`NUM_WARP_LOG-1:0] decodedWarp_o,
				output decodedPacket0Valid_o,
				output [`LDST_SPACE_LOG+6+`INST_TYPES_LOG+`SIZE_IMMEDIATE+4*(`SIZE_REGFILE+1)
							+`SIZE_OPCODE+`SIZE_RP+1+3*`SIZE_PC-1
							:0] decodedPacket0_o,
				output decodedPacket1Valid_o,
				output [`LDST_SPACE_LOG+6+`INST_TYPES_LOG+`SIZE_IMMEDIATE+4*(`SIZE_REGFILE+1)
							+`SIZE_OPCODE+`SIZE_RP+1+3*`SIZE_PC-1
							:0] decodedPacket1_o						
				);
				
	assign decodedWarp_o = instWarp_i;
	assign decodedPacket0Valid_o = instPacket0Valid_i;
	assign decodedPacket1Valid_o = instPacket1Valid_i;
	
	Decode_PTX decode_PTX0(	.reset(reset),
					.clk(clk),
				
					.instPachet_i(instPachet0_i),
				
					.decodedPacket_o(decodedPacket0_o)
					);	
					
	Decode_PTX decode_PTX1(	.reset(reset),
				.clk(clk),
			
				.instPachet_i(instPachet1_i),
			
				.decodedPacket_o(decodedPacket1_o)
				);						
				
endmodule
