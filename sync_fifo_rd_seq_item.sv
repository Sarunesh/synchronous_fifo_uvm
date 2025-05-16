class sync_fifo_rd_seq_item extends uvm_sequence_item;
	//Properties
	rand bit rd_en;
		 bit [WIDTH-1:0] rdata;
		 bit rd_err;
	
	//Factory registration
	`uvm_object_utils_begin(sync_fifo_rd_seq_item)
		`uvm_field_int(rd_en,UVM_ALL_ON)
		`uvm_field_int(rdata,UVM_ALL_ON)
		`uvm_field_int(rd_err,UVM_ALL_ON)
	`uvm_object_utils_end

	//Constructor
	`NEW_OBJECT
endclass: sync_fifo_rd_seq_item
