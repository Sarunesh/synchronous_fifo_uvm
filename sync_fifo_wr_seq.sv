class sync_fifo_wr_seq extends uvm_sequence#(sync_fifo_wr_seq_item);
	//Factory registration
	`uvm_object_utils(sync_fifo_wr_seq)

	//Constructor
	`NEW_OBJECT

	//body task
	virtual task body();
		`uvm_info("SYNC_FIFO_WR_SEQ","Base seq for write",UVM_HIGH)
	endtask: body
endclass: sync_fifo_wr_seq

/************************** Scenario-1 *****************************/
class write_seq extends sync_fifo_wr_seq;
	`uvm_object_utils(write_seq)
	`NEW_OBJECT

	virtual task body();
		`uvm_info("SYNC_FIFO_WR_SEQ","write_seq",UVM_HIGH)
		//Logic
		`uvm_do_with(req,{req.wr_en==1;})
		req.print();
	endtask: body
endclass: write_seq
/*******************************************************************/
/************************** Scenario-2 *****************************/
/*******************************************************************/
/************************** Scenario-3 *****************************/
/*******************************************************************/
/************************** Scenario-4 *****************************/
/*******************************************************************/
/************************** Scenario-5 *****************************/
/*******************************************************************/
/************************** Scenario-6 *****************************/
/*******************************************************************/
