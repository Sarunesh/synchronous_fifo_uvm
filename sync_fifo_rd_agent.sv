class sync_fifo_rd_agent extends uvm_agent;
	//Factory registration
	`uvm_component_utils(sync_fifo_rd_agent)

	//Constructor
	`NEW_COMPONENT

	//Properties
	sync_fifo_rd_agent_config rd_cfg;
	sync_fifo_rd_sqr rd_sqr;
	sync_fifo_rd_drv rd_drv;
	sync_fifo_rd_mon rd_mon;

	//build_phase
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		rd_mon = sync_fifo_rd_mon::type_id::create("rd_mon",this);

		if(!uvm_config_db#(sync_fifo_rd_agent_config)::get(this,"","RD_CFG",rd_cfg))
			`uvm_fatal(get_full_name(),"!!!! Unable to get rd_cfg in sync_fifo_rd_agent !!!!")

		if(rd_cfg.is_active == UVM_ACTIVE)begin
			rd_sqr = sync_fifo_rd_sqr::type_id::create("rd_sqr",this);
			rd_drv = sync_fifo_rd_drv::type_id::create("rd_drv",this);
		end

		`uvm_info(get_type_name(),"Inside build_phase of sync_fifo_rd_agent",UVM_HIGH)
	endfunction: build_phase

	//connect_phase
	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		if(rd_cfg.is_active == UVM_ACTIVE)
			//rd_drv.seq_item_port.connect(rd_sqr.seq_item_export);	//sqr to drv
			`CONNECT_IF_NOT_NULL(rd_drv.seq_item_port, rd_sqr.seq_item_export);

		`uvm_info(get_type_name(),"Inside connect_phase of sync_fifo_rd_agent",UVM_HIGH)
	endfunction: connect_phase
endclass: sync_fifo_rd_agent
