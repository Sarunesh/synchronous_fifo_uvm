class sync_fifo_v_sqr extends uvm_sequencer#(uvm_sequence_item);
//Factory registration
	`uvm_component_utils(sync_fifo_v_sqr)

//Constructor
	`NEW_COMPONENT

	sync_fifo_wr_sqr wr_sqr;
	sync_fifo_rd_sqr rd_sqr;
endclass: sync_fifo_v_sqr
