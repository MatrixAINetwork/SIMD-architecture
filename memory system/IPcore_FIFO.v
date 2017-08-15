`define FIFOSIZE 32
`define FIFOSIZE_LOG 5
`define SIZE_TIME_DELAY 10 
`define SIZE_COUNT 16
`define SIZE_RAM 32
`define SIZE_RAM_LOG 5
module MemAccessFIFO(
	input clk,
	input reset,
	input stall_i,
	input i,
	input [`SIZE_RAM_LOG - 1 : 0] RAM_Addr_i, 
	input [9:0] Delay,
	input [`SIZE_COUNT - 1:0] count,
	input o,
	input FIFOIn,
	input [`SIZE_ADDR - 1 : 0] FIFOAddrIn,
	output wire [`SIZE_ADDR - 1 : 0] FIFOAddrOut,
	output wire [`SIZE_RAM_LOG - 1 : 0] RAM_Addr_o,
	output wire [`SIZE_COUNT - 1:0] HeadOutTime,	
	output wire [`SIZE_COUNT - 1:0] HeadInTime,
	output wire full
	);
	wire [`SIZE_RAM_LOG + 2 * `SIZE_COUNT - 1 : 0] memAccessBundle_push , memAccessBundle_top;
	reg [`FIFOSIZE_LOG - 1 : 0] num;
	reg [`FIFOSIZE_LOG - 1 : 0] tail;
	reg [`FIFOSIZE_LOG - 1 : 0] head;
	
	assign full = ( num == `FIFOSIZE - 1 )? 1'b1:1'b0;
	assign memAccessBundle_push = {RAM_Addr_i , count, count + Delay};
	
	
	assign RAM_Addr_o =  memAccessBundle_top[`SIZE_RAM_LOG + 2 * `SIZE_COUNT - 1 : 2 * `SIZE_COUNT];
	assign HeadInTime =  memAccessBundle_top[ 2 * `SIZE_COUNT - 1 : `SIZE_COUNT];
	assign HeadOutTime = memAccessBundle_top[`SIZE_COUNT - 1 : 0];
	always @(posedge clk)
	begin
		if(reset)
		begin
			num <= 0;
			tail <= 0;
			head <= 0;		
		end
		else if(~stall_i)
		begin
			if(i & FIFOIn & (~full))
			begin
				tail <= tail + 1;
				num <= tail - head;
			end			
			if(o)
			begin
				head <= head + 1;
				num <= tail - head;
			end		
		end		
	end
	IPCore_DisRAM_SimplePort #(`FIFOSIZE, `FIFOSIZE_LOG, `SIZE_RAM_LOG + 2 * `SIZE_COUNT)
		memAccessBundleRam(
		  .a(tail),//addr_write
		  .d(memAccessBundle_push),//din
		  .dpra(head),//addr_read
		  .clk(clk),
		  .we(i && (~full) && (~stall_i) && FIFOIn),
		  .dpo(memAccessBundle_top)//dout
		);
	IPCore_DisRAM_SimplePort #(`FIFOSIZE, `FIFOSIZE_LOG, `SIZE_ADDR)
		memAccessBundleRam1(
		  .a(tail),//addr_write
		  .d(FIFOAddrIn),//din
		  .dpra(head),//addr_read
		  .clk(clk),
		  .we(i && (~full) && (~stall_i) && FIFOIn),
		  .dpo(FIFOAddrOut)//dout
		);
	endmodule
