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
		`uvm_info(get_type_name(),
			"Inside build_phase of sync_fifo_rd_agent",
			UVM_HIGH)

		`uvm_info(get_type_name(),
			$sformatf(">>>> %0t Before getting rd_cfg in rd_agent <<<<",$time),
			UVM_DEBUG)

		if(!uvm_config_db#(sync_fifo_rd_agent_config)::get(this,"","RD_CFG",rd_cfg))
			`uvm_error(get_type_name(),
				"!!!! Unable to get rd_cfg in sync_fifo_rd_agent !!!!")

		`uvm_info(get_type_name(),
			$sformatf(">>>> %0t After getting rd_cfg in rd_agent <<<<",$time),
			UVM_DEBUG)

		if(rd_cfg.is_active == UVM_ACTIVE)begin
			`uvm_info(get_type_name(),
				"rd_agent is Active",
				UVM_LOW)

			rd_sqr = sync_fifo_rd_sqr::type_id::create("rd_sqr",this);
			`UVM_NULL_CHECK(rd_sqr,get_type_name())

			`uvm_info(get_type_name(),
				$sformatf(">>>> Created rd_sqr of type: %0s <<<<", rd_sqr.get_type_name()),
				UVM_DEBUG)

			rd_drv = sync_fifo_rd_drv::type_id::create("rd_drv",this);
			`UVM_NULL_CHECK(rd_drv,get_type_name())
		end
		else
			`uvm_info(get_type_name(),
				"rd_agent is Passive",
				UVM_LOW)

		rd_mon = sync_fifo_rd_mon::type_id::create("rd_mon",this);
		`UVM_NULL_CHECK(rd_mon,get_type_name())
	endfunction: build_phase

//connect_phase
	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		`uvm_info(get_type_name(),
			"Inside connect_phase of sync_fifo_rd_agent",
			UVM_HIGH)

		if(rd_cfg.is_active == UVM_ACTIVE)
			//rd_drv.seq_item_port.connect(rd_sqr.seq_item_export);	//sqr to drv
			`CONNECT_IF_NOT_NULL(rd_drv.seq_item_port, rd_sqr.seq_item_export);
	endfunction: connect_phase
endclass: sync_fifo_rd_agent
