module sync_fifo(rdata, wr_err, rd_err, clk, rst, wdata, wr_en, rd_en);
	parameter WIDTH=16;
	parameter DEPTH=16;
	parameter PTR_WIDTH=$clog2(DEPTH);

	output reg [WIDTH-1:0] rdata;
	output reg wr_err;
	output reg rd_err;
	input clk;
	input rst;
	input [WIDTH-1:0] wdata;
	input wr_en;
	input rd_en;

	//Internal registers
	reg [WIDTH-1:0] mem [DEPTH-1:0];
	reg [PTR_WIDTH-1:0] wr_ptr;
	reg [PTR_WIDTH-1:0] rd_ptr;
	reg full;							// To facilitate Write operation
	reg empty;							// To facilitate Read operation
	reg rd_tgl_f;
	reg wr_tgl_f;
	integer i;

	// Write
	always@(posedge clk)begin
		if(rst)begin							// Reset is applied
			wr_ptr	<=0;
			wr_err	<=0;
			wr_tgl_f<=0;
			for(i=0;i<DEPTH;i=i+1) mem[i]<=0;
		end
		else begin								// Reset is not applied
			if(wr_en)begin						// Write enable is provided
				if(full) wr_err<=1'b1;			// FIFO is full
				else begin						// FIFO is not full-Write can be performed
					wr_err		<= 1'b0;
					mem[wr_ptr] <= wdata;
					if(wr_ptr == DEPTH-1)begin
						wr_ptr	<= 0;
						wr_tgl_f<= ~wr_tgl_f;
					end
					else wr_ptr	<= wr_ptr+1;
				end
			end
			else wr_err <= 1'b0;				//!wr_en
		end
	end

	// Read
	always@(posedge clk)begin
		if(rst)begin							// Reset is applied
			rd_ptr	<= 0;
			rd_err	<= 0;
			rd_tgl_f<= 0;
		end
		else begin								// Reset is not applied
			if(rd_en)begin					// Read enable is provided
				if(empty) rd_err <= 1'b1;			// FIFO is empty
				else begin						// FIFO is not empty-Read can be performed
					rd_err<= 1'b0;
					rdata <= mem[rd_ptr];
					if(rd_ptr == DEPTH-1)begin
						rd_ptr	<= 0;
						rd_tgl_f<= ~rd_tgl_f;
					end
					else rd_ptr	<=rd_ptr+1;
				end
			end
			else rd_err <= 1'b0;
		end
	end

	// Updating full and empty flags
	always@(posedge clk)begin
		if(rst)begin
			empty <= 1'b1;
			full  <= 1'b0;
		end
		else begin
			empty <= (wr_ptr==rd_ptr)&&(wr_tgl_f==rd_tgl_f);
			full  <= (wr_ptr==rd_ptr)&&(wr_tgl_f!=rd_tgl_f);
		end
	end
endmodule: sync_fifo
