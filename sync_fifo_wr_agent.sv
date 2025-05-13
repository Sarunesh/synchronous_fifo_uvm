class sync_fifo_wr_agent extends uvm_agent;
	//Factory registration
	`uvm_component_utils(sync_fifo_wr_agent)

	//Constructor
	`NEW_COMPONENT

	//Properties
	sync_fifo_wr_agent_config wr_cfg;
	sync_fifo_wr_sqr wr_sqr;
	sync_fifo_wr_drv wr_drv;
	sync_fifo_wr_mon wr_mon;

	//build_phase
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		wr_mon = sync_fifo_wr_mon::type_id::create("wr_mon",this);

//`uvm_info("Debug",$sformatf("#### %0t Before getting wr_cfg in wr_agent ####",$time),UVM_HIGH)
		if(!uvm_config_db#(sync_fifo_wr_agent_config)::get(this,"","WR_CFG",wr_cfg))
			`uvm_fatal(get_full_name(),"!!!! Unable to get wr_cfg in sync_fifo_wr_agent !!!!")

//`uvm_info("Debug",$sformatf("#### %0t After getting wr_cfg in wr_agent ####",$time),UVM_HIGH)

		if(wr_cfg.is_active==UVM_ACTIVE)begin
		//if(get_is_active()==UVM_ACTIVE)begin		//bit type
			wr_sqr = sync_fifo_wr_sqr::type_id::create("wr_sqr",this);
			wr_drv = sync_fifo_wr_drv::type_id::create("wr_drv",this);
		end

		`uvm_info(get_type_name(),"Inside build_phase of sync_fifo_wr_agent",UVM_HIGH)
	endfunction: build_phase

	//connect_phase
	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		if(wr_cfg.is_active==UVM_ACTIVE)
			//wr_drv.seq_item_port.connect(wr_sqr.seq_item_export);	//sqr to drv
			`CONNECT_IF_NOT_NULL(wr_drv.seq_item_port, wr_sqr.seq_item_export);

		`uvm_info(get_type_name(),"Inside connect_phase of sync_fifo_wr_agent",UVM_HIGH)
	endfunction: connect_phase
endclass: sync_fifo_wr_agent
