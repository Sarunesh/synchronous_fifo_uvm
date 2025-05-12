package common_pkg;
	parameter WIDTH=16;
	parameter DEPTH=16;
	parameter DATA_RANGE=(2**WIDTH)-1;

	class sync_fifo_common;
		static int match_count;
		static int mismatch_count;
	endclass: sync_fifo_common
endpackage: common_pkg
