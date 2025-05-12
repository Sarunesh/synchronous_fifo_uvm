class sync_fifo_env extends uvm_env;
//Factory registration
	`uvm_component_utils(sync_fifo_env)

//Constructor
	`NEW_COMPONENT

//env_cfg
	sync_fifo_env_config env_cfg;

//virtual sequencer, sbd, agents instantiation
	sync_fifo_v_sqr v_sqr;
	sync_fifo_wr_agent wr_agent;
	sync_fifo_rd_agent rd_agent;
	sync_fifo_sbd sbd;
	sync_fifo_wr_sub wr_sub;
	sync_fifo_rd_sub rd_sub;

//build_phase
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db#(sync_fifo_env_config)::get(this,"","ENV_CFG",env_cfg))
			`uvm_fatal(get_full_name(),"!!!! Unable to get env_cfg in sync_fifo_env !!!!")

		v_sqr	= sync_fifo_v_sqr::type_id::create("v_sqr",this);
		wr_agent= sync_fifo_wr_agent::type_id::create("wr_agent",this);
		rd_agent= sync_fifo_rd_agent::type_id::create("rd_agent",this);
		sbd		= sync_fifo_sbd::type_id::create("sbd",this);

		if(env_cfg.has_wr_subscriber)
			wr_sub	= sync_fifo_wr_sub::type_id::create("wr_sub",this);
		if(env_cfg.has_rd_subscriber)
			rd_sub	= sync_fifo_rd_sub::type_id::create("rd_sub",this);

		`uvm_info(get_type_name(),"Inside build_phase of sync_fifo_env",UVM_HIGH)
	endfunction: build_phase

//connect_phase
	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		if(env_cfg.wr_cfg.is_active==UVM_ACTIVE)
			v_sqr.wr_sqr=wr_agent.wr_sqr;
		if(env_cfg.rd_cfg.is_active==UVM_ACTIVE)
			v_sqr.rd_sqr=rd_agent.rd_sqr;

		//wr_mon and rd_mon to sbd
		//wr_agent.wr_mon.ap_wr.connect(sbd.wr_imp);
		//rd_agent.rd_mon.ap_rd.connect(sbd.rd_imp);
		`CONNECT_IF_NOT_NULL(wr_agent.wr_mon.ap_wr, sbd.wr_imp);
		`CONNECT_IF_NOT_NULL(rd_agent.rd_mon.ap_rd, sbd.rd_imp);

		//wr_sub and rd_sub to mon
		if(env_cfg.has_wr_subscriber)
			//wr_agent.wr_mon.ap_wr.connect(wr_sub.analysis_export);
			`CONNECT_IF_NOT_NULL(wr_agent.wr_mon.ap_wr, wr_sub.analysis_export);
		if(env_cfg.has_rd_subscriber)
			//rd_agent.rd_mon.ap_rd.connect(rd_sub.analysis_export);
			`CONNECT_IF_NOT_NULL(rd_agent.rd_mon.ap_rd, rd_sub.analysis_export);
	endfunction: connect_phase

endclass: sync_fifo_env
