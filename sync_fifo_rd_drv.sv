class sync_fifo_rd_drv extends uvm_driver#(sync_fifo_rd_seq_item);
//Factory registration
	`uvm_component_utils(sync_fifo_rd_drv)

//Constructor
	`NEW_COMPONENT

//Properties
	virtual sync_fifo_intf vif;

//build_phase
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info(get_type_name(),
			"Inside build_phase of sync_fifo_rd_drv",
			UVM_HIGH)

		if(!uvm_config_db#(virtual sync_fifo_intf)::get(this,"","VIF",vif))
			`uvm_error(get_type_name(),"!!!! Couldn't get the interface from config_db in sync_fifo_rd_drv !!!!")
	endfunction: build_phase
	
	//run_phase
	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info(get_type_name(),
			"Inside run_phase of sync_fifo_rd_drv",
			UVM_HIGH)

		wait(!vif.rst);
		forever begin
			`uvm_info(get_type_name(),
				">>>> About to seq_item_port.get_next_item(req) <<<<",
				UVM_DEBUG)
			seq_item_port.get_next_item(req);
			`uvm_info(get_type_name(),
				">>>> Passed seq_item_port.get_next_item(req) <<<<",
				UVM_DEBUG)

			`uvm_info(get_type_name(),
				">>>> Driving signals to DUT <<<<",
				UVM_DEBUG)
			rd_drive(req);

			`uvm_info(get_type_name(),
				">>>> About to seq_item_port.item_done(req) <<<<",
				UVM_DEBUG)
			seq_item_port.item_done(req);
			`uvm_info(get_type_name(),
				">>>> Passed seq_item_port.item_done(req) <<<<",
				UVM_DEBUG)
		end
	endtask: run_phase

	//drive task
	task rd_drive(sync_fifo_rd_seq_item rd_tx);
		`uvm_info(get_type_name(),
			"Driving signals in sync_fifo_rd_drv",
			UVM_HIGH)

		@(posedge vif.clk);
		vif.rd_en	<= rd_tx.rd_en;
		rd_tx.rdata	<=vif.rdata;
		rd_tx.rd_err<=vif.rd_err;
		`uvm_info(get_full_name(),"---- Transaction details ----", UVM_HIGH)
		rd_tx.print();

		@(posedge vif.clk);
		vif.rd_en <=0;
	endtask: rd_drive
endclass: sync_fifo_rd_drv
