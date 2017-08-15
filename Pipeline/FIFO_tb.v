module FIFO_tb;

	// Inputs
	reg clk;
	reg reset;
	reg stall_i;
	reg i;
	reg [4:0] RAM_Addr_i;
	reg [9:0] Delay;
	reg [15:0] count;
	reg o;
	reg FIFOIn;

	// Outputs
	wire [4:0] RAM_Addr_o;
	wire [15:0] HeadOutTime;
	wire [15:0] HeadInTime;
	wire full;

	// Instantiate the Unit Under Test (UUT)
	MemAccessFIFO uut (
		.clk(clk), 
		.reset(reset), 
		.stall_i(stall_i), 
		.i(i), 
		.RAM_Addr_i(RAM_Addr_i), 
		.Delay(Delay), 
		.count(count), 
		.o(o), 
		.FIFOIn(FIFOIn), 
		.RAM_Addr_o(RAM_Addr_o), 
		.HeadOutTime(HeadOutTime), 
		.HeadInTime(HeadInTime), 
		.full(full)
	);

	initial begin
		// Initialize Inputs
		clk = 1;
		reset = 0;
		stall_i = 0;
		i = 0;
		RAM_Addr_i = 0;
		Delay = 0;
		count = 0;
		o = 0;
		FIFOIn = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	initial fork
	forever #5 clk <= ~clk;
	forever #10 count <= count + 1;
	#20 reset <= 1;
	#30 reset <= 0;
	#40 i <= 1;
	#40 Delay <= 10;
	#40 RAM_Addr_i <= 5'b00001;
	#100 o <= 1;
	#40 FIFOIn <= 1;
     
	 
	join
endmodule

