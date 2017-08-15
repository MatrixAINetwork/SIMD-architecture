
module L1Tag_tb;

	// Inputs
	reg reset;
	reg clk;
	reg stall;
	reg [31:0] L1TagWriteAddr;
	reg L1TagWrite;
	reg [4:0] SegNum;
	reg [31:0] Coalesce2L1_o;

	// Outputs
	wire [9:0] Delay;
	wire L1_HIT;

	// Instantiate the Unit Under Test (UUT)
	L1TagUnit uut (
		.reset(reset), 
		.clk(clk), 
		.stall(stall), 
		.L1TagWriteAddr(L1TagWriteAddr), 
		.L1TagWrite(L1TagWrite), 
		.SegNum(SegNum), 
		.Coalesce2L1_o(Coalesce2L1_o), 
		.Delay(Delay), 
		.L1_HIT(L1_HIT)
	);

	initial begin
		// Initialize Inputs
		reset = 0;
		clk = 1;
		stall = 0;
		L1TagWriteAddr = 0;
		L1TagWrite = 0;
		SegNum = 0;
		Coalesce2L1_o = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
	initial fork
		forever #5 clk <= ~clk;
		#20 reset <= 1;
		#30 reset <= 0;
		#101 L1TagWriteAddr <= 32'b10101010_10101010_10101010_10101010;
		#101 L1TagWrite <= 1;
		#111 L1TagWriteAddr <= 32'b10101010_10101010_10101010_11101010;
		#121 L1TagWriteAddr <= 32'b10101010_10101010_10101011_11101010;
		#131 L1TagWriteAddr <= 32'b10101010_10101010_10101111_11101010;
		#91  Coalesce2L1_o <= 32'b10101010_10101010_10101010_10101010;
		#101  Coalesce2L1_o <= 32'b10101010_10101010_10101010_10101010;
		#111  Coalesce2L1_o <= 32'b10101010_10101010_10101010_10101010;
		#151  Coalesce2L1_o <= 32'b10101010_10101010_10101111_11101010;
		#201  Coalesce2L1_o <= 0;
	join
endmodule

