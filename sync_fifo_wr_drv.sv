class sync_fifo_wr_drv extends uvm_driver#(sync_fifo_wr_seq_item);
	//Factory registration
	`uvm_component_utils(sync_fifo_wr_drv)

	//Constructor
	`NEW_COMPONENT

	//Properties
	virtual sync_fifo_intf vif;

	//build_phase
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual sync_fifo_intf)::get(this,"","VIF",vif))
			`uvm_fatal(get_full_name(),"!!!! Couldn't get the interface from config_db in sync_fifo_wr_drv !!!!")
		`uvm_info(get_type_name(),"Inside build_phase of sync_fifo_wr_drv",UVM_HIGH)
	endfunction: build_phase
	
	//run_phase
	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info(get_type_name(),"Inside run_phase of sync_fifo_wr_drv",UVM_HIGH)
		wait(!vif.rst);
		forever begin
			seq_item_port.get_next_item(req);
			wr_drive(req);
			seq_item_port.item_done(req);
		end
	endtask: run_phase

	//drive task
	task wr_drive(sync_fifo_wr_seq_item wr_tx);
		`uvm_info(get_type_name(),"Driving signals in sync_fifo_wr_drv",UVM_HIGH)

		@(posedge vif.clk);
		vif.wdata	<= wr_tx.wdata;
		vif.wr_en 	<= wr_tx.wr_en;
		wr_tx.wr_err<= vif.wr_err;

		wr_tx.print();

		@(posedge vif.clk);
		vif.wdata <= 0;
		vif.wr_en <= 0;
	endtask: wr_drive
endclass: sync_fifo_wr_drv
