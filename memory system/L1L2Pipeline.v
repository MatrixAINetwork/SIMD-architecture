`define L1Delay 1
`define L2Delay 20
`define DRAMDelay 400
`define RAM_SIZE_LOG 5
module L1L2Pipeline(
		input reset,
		input clk,
		input stall,
		
		input [`SIZE_CORE_LOG - 1:0] SegNum,			
		
		output reg [9:0] Delay
);
	always @ (posedge clk)
	begin
		if(reset)
		begin
			Delay <= 0;
			end
		else if (~stall)
		begin
			Delay <= `DRAMDelay - 1;	
		end
	end
endmodule

module SharedPipeline(
		input reset,
		input clk,
		input stall,
		
		input [`SIZE_CORE_LOG - 1:0] SegNum,			
		
		output reg [9:0] Delay
);
	always @ (posedge clk)
	begin
		if(reset)
		begin
			Delay <= 0;
			end
		else if (~stall)
		begin
			Delay <= 1;	
		end
	end
endmodule