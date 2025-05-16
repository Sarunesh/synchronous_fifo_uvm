import common_pkg::*;
module top;
	logic clk;
	logic rst;

	//Interface instantiation
	sync_fifo_intf pif(.clk(clk), .rst(rst));

	//DUT instantiation
	sync_fifo#(.DEPTH(DEPTH), .WIDTH(WIDTH)) dut(	.rdata	(pif.rdata),
													.wr_err	(pif.wr_err),
													.rd_err	(pif.rd_err),
													.clk	(pif.clk),
													.rst	(pif.rst),
													.wdata	(pif.wdata),
													.wr_en	(pif.wr_en),
													.rd_en	(pif.rd_en));
	
	//Clock generation
	always #5 clk=~clk;

	//Initialization
	initial begin
		clk=0; rst=1;
		repeat(2)@(posedge clk);
		rst=0;
		#1000 $finish;
	end

	//run_test
	initial begin
		//Set interface to config db
		uvm_config_db#(virtual sync_fifo_intf)::set(null,"*","VIF",pif);
		run_test();
	end
endmodule: top
