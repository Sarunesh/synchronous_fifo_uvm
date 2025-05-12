class sync_fifo_wr_mon extends uvm_monitor;
	//Factory registration
	`uvm_component_utils(sync_fifo_wr_mon)

	//Constructor
	`NEW_COMPONENT

	//Port declaration
	uvm_analysis_port#(sync_fifo_wr_seq_item) ap_wr;

	//Properties
	virtual sync_fifo_intf vif;
	sync_fifo_wr_seq_item wr_tx;

	//build_phase
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ap_wr=new("ap_wr",this);
		if(!uvm_config_db#(virtual sync_fifo_intf)::get(this,"","VIF",vif))
			`uvm_fatal(get_full_name(),"!!!! Couldn't get the interface from config_db in sync_fifo_wr_mon !!!!")
		`uvm_info(get_type_name(),"Inside build_phase of sync_fifo_wr_mon",UVM_HIGH)
	endfunction: build_phase

	//run_phase
	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);
		`uvm_info(get_type_name(),"Inside run_phase of sync_fifo_wr_mon",UVM_HIGH)
		wr_capture();
	endtask: run_phase

	//wr_capture task
	task wr_capture();
		`uvm_info(get_type_name(),"Inside wr_capture task of sync_fifo_wr_mon",UVM_HIGH)
		forever begin
			@(posedge vif.clk);
			//if(vif.wr_en)begin
				wr_tx = new();
				wr_tx.wr_en = vif.wr_en;
				wr_tx.wr_err= vif.wr_err;
				if(vif.wr_en && !vif.wr_err) wr_tx.wdata = vif.wdata;

				ap_wr.write(wr_tx);
				wr_tx.print();
			//end
		end
	endtask: wr_capture
endclass: sync_fifo_wr_mon
