interface sync_fifo_intf(input logic clk, input logic rst);
	logic [WIDTH-1:0] rdata;
	logic wr_err;
	logic rd_err;
	logic [WIDTH-1:0] wdata;
	logic wr_en;
	logic rd_en;
endinterface: sync_fifo_intf
