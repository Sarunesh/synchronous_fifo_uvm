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
		if(!uvm_config_db#(virtual sync_fifo_intf)::get(this,"","VIF",vif))
			`uvm_fatal(get_full_name(),"!!!! Couldn't get the interface from config_db in sync_fifo_rd_drv !!!!")
		`uvm_info(get_type_name(),"Inside build_phase of sync_fifo_rd_drv",UVM_HIGH)
	endfunction: build_phase
	
	//run_phase
	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);
		wait(!vif.rst);
		forever begin
			seq_item_port.get_next_item(req);
			rd_drive(req);
			seq_item_port.item_done(req);
		end
		`uvm_info(get_type_name(),"Inside run_phase of sync_fifo_rd_drv",UVM_HIGH)
	endtask: run_phase

	//drive task
	task rd_drive(sync_fifo_rd_seq_item rd_tx);
		`uvm_info(get_type_name(),"Driving signals in sync_fifo_rd_drv",UVM_HIGH)

		@(posedge vif.clk);
		vif.rd_en	<= rd_tx.rd_en;
		rd_tx.rdata	<=vif.rdata;
		rd_tx.rd_err<=vif.rd_err;

		@(posedge vif.clk);
		vif.rd_en <=0;
	endtask: rd_drive
endclass: sync_fifo_rd_drv
