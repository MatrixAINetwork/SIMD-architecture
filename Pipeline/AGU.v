module AGU (
		input [`SIZE_DATA-1:0] 		data1_i,		
		input [`SIZE_IMMEDIATE-1:0] 	immd_i,

		output [`SIZE_DATA-1:0] 	result_o
	    ); 


	reg [`SIZE_DATA-1:0] 		result;


	assign result_o    = result;




	always @(*)
	begin:ALU_OPERATION
	  reg [`SIZE_DATA-1:0] sign_ex_immd;
		
		if(immd_i[`SIZE_IMMEDIATE-1] == 1'b1)
			sign_ex_immd = {16'b1111111111111111,immd_i};
		else
			sign_ex_immd = {16'b0000000000000000,immd_i};

		result 	   = data1_i + sign_ex_immd;
		
	end    

endmodule