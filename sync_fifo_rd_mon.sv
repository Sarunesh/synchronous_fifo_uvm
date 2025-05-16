class sync_fifo_rd_mon extends uvm_monitor;
//Factory registration
	`uvm_component_utils(sync_fifo_rd_mon)

//Constructor
	`NEW_COMPONENT

//Port declaration
	uvm_analysis_port#(sync_fifo_rd_seq_item) ap_rd;

//Properties
	virtual sync_fifo_intf vif;
	sync_fifo_rd_seq_item rd_tx;

//build_phase
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info(get_type_name(),
			"Inside build_phase of sync_fifo_rd_mon",
			UVM_HIGH)
		ap_rd=new("ap_rd",this);
		if(!uvm_config_db#(virtual sync_fifo_intf)::get(this,"","VIF",vif))
			`uvm_error(get_type_name(),"!!!! Couldn't get the interface from config_db in sync_fifo_rd_mon !!!!")
	endfunction: build_phase

	//run_phase
	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info(get_type_name(),
			"Inside run_phase of sync_fifo_rd_mon",
			UVM_HIGH)
		rd_capture();
	endtask: run_phase

	//rd_capture task
	task rd_capture();
		`uvm_info(get_type_name(),
			"Inside rd_capture task of sync_fifo_rd_mon",
			UVM_HIGH)
		@(posedge vif.clk);
		//if(vif.rd_en)begin
			rd_tx = new();
			rd_tx.rd_en	= vif.rd_en;
			rd_tx.rd_err= vif.rd_err;
			if(vif.rd_en && !vif.rd_err) rd_tx.rdata = vif.rdata;

			ap_rd.write(rd_tx);
			rd_tx.print();
		//end
	endtask: rd_capture
endclass: sync_fifo_rd_mon
