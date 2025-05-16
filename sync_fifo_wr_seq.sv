class sync_fifo_wr_seq extends uvm_sequence#(sync_fifo_wr_seq_item);
//Factory registration
	`uvm_object_utils(sync_fifo_wr_seq)

//Constructor
	`NEW_OBJECT

//body task
	virtual task body();
		`uvm_info(get_type_name(),
			"Base seq for write",
			UVM_HIGH)

		req=sync_fifo_wr_seq_item::type_id::create("req");
		`uvm_info(get_type_name(),
			$sformatf(">>>> Sequencer type: %0s <<<<", get_sequencer().get_type_name()),
			UVM_DEBUG)
	endtask: body
endclass: sync_fifo_wr_seq

/************************** Scenario-1 *****************************/
class write_seq extends sync_fifo_wr_seq;
	`uvm_object_utils(write_seq)
	`NEW_OBJECT

	virtual task body();
		super.body();
		`uvm_info(get_type_name(),
			"Inside body task of write_seq",
			UVM_HIGH)
//Logic
		`uvm_do_with(req,{req.wr_en==1;})

/*		`uvm_info(get_type_name(),
			">>>> About to start_item(req) <<<<<",
			UVM_DEBUG)
		start_item(req);
		`uvm_info(get_type_name(),
			">>>> Passed start_item(req) <<<<<",
			UVM_DEBUG)

		if(!req.randomize() with {req.wr_en==1;})
			`uvm_error(get_type_name(),"Randomization failed")

		`uvm_info(get_type_name(),
			">>>> About to finish_item(req) <<<<<",
			UVM_DEBUG)
		finish_item(req);
		`uvm_info(get_type_name(),
			">>>> Passed finish_item(req) <<<<<",
			UVM_DEBUG)
*/
		`uvm_info(get_full_name(),"---- Transaction details ----", UVM_HIGH)
		req.print();
		`uvm_info(get_type_name(),
			">>>> Exiting body task of write_seq <<<<",
			UVM_DEBUG)
	endtask: body
endclass: write_seq
/*******************************************************************/
/************************** Scenario-2 *****************************/
class burst4_write_seq extends sync_fifo_wr_seq;
	`uvm_object_utils(burst4_write_seq)
	`NEW_OBJECT

	virtual task body();
		super.body();
		`uvm_info(get_type_name(),
			"Inside body task of burst4_write_seq",
			UVM_HIGH)
//Logic
		repeat(4)begin
			`uvm_do_with(req,{req.wr_en==1;})
			`uvm_info(get_full_name(),"---- Transaction details ----", UVM_HIGH)
			req.print();
		end

		`uvm_info(get_type_name(),
			">>>> Exiting body task of burst4_write_seq <<<<",
			UVM_DEBUG)
	endtask: body
endclass: burst4_write_seq
/*******************************************************************/
/************************** Scenario-3 *****************************/
class full_depth_write_seq extends sync_fifo_wr_seq;
	`uvm_object_utils(full_depth_write_seq)
	`NEW_OBJECT

	virtual task body();
		super.body();
		`uvm_info(get_type_name(),
			"Inside body task of full_depth_write_seq",
			UVM_HIGH)
//Logic
		repeat(DEPTH)begin
			`uvm_do_with(req,{req.wr_en==1;})
			`uvm_info(get_full_name(),"---- Transaction details ----", UVM_HIGH)
			req.print();
		end

		`uvm_info(get_type_name(),
			">>>> Exiting body task of full_depth_write_seq <<<<",
			UVM_DEBUG)
	endtask: body
endclass: full_depth_write_seq
/*******************************************************************/
/************************** Scenario-4 *****************************/
/*******************************************************************/
/************************** Scenario-5 *****************************/
/*******************************************************************/
/************************** Scenario-6 *****************************/
/*******************************************************************/
