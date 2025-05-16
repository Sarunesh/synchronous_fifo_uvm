class sync_fifo_wr_seq_item extends uvm_sequence_item;
//Properties
	rand bit [WIDTH-1:0] wdata;
	rand bit wr_en;
		 bit wr_err;
	
//Factory registration
	`uvm_object_utils_begin(sync_fifo_wr_seq_item)
		`uvm_field_int(wr_en,UVM_ALL_ON)
		`uvm_field_int(wdata,UVM_ALL_ON)
		`uvm_field_int(wr_err,UVM_ALL_ON)
	`uvm_object_utils_end

//Constructor
	`NEW_OBJECT

//Constraints
	constraint wdata_c{
		wdata inside {[0:DATA_RANGE]};
	}
endclass: sync_fifo_wr_seq_item
