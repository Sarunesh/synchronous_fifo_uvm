class sync_fifo_v_seq extends uvm_sequence#(uvm_sequence_item);
//Factory registration
	`uvm_object_utils(sync_fifo_v_seq)
//Constructor
	`NEW_OBJECT

//Properties
	uvm_phase starting_phase;

//v_sqr, base_seq instantiation
	sync_fifo_v_sqr v_sqr;
	sync_fifo_wr_seq wr_seq;
	sync_fifo_rd_seq rd_seq;
	sync_fifo_wr_agent_config wr_cfg;
	sync_fifo_rd_agent_config rd_cfg;

//body task
	virtual task body();
		//m_sequencer=env.v_sqr; //built-in

		if(!$cast(v_sqr,m_sequencer))
			`uvm_fatal(get_full_name(),"!!!! Casting failed in sync_fifo_v_seq !!!!")

		if(!uvm_config_db#(sync_fifo_wr_agent_config)::get(null,"","WR_CFG",wr_cfg))
			`uvm_fatal(get_full_name(),"!!!! Unable to get wr_cfg in sync_fifo_v_seq !!!!")
		if(!uvm_config_db#(sync_fifo_rd_agent_config)::get(null,"","RD_CFG",rd_cfg))
			`uvm_fatal(get_full_name(),"!!!! Unable to get rd_cfg in sync_fifo_v_seq !!!!")

		if(starting_phase!=null)
			starting_phase.raise_objection(this);

		if(wr_cfg.is_active==UVM_ACTIVE)begin
			wr_seq = sync_fifo_wr_seq::type_id::create("wr_seq");			// Since object
			wr_seq.start(v_sqr.wr_sqr);
		end
		if(rd_cfg.is_active==UVM_ACTIVE)begin
			rd_seq = sync_fifo_rd_seq::type_id::create("rd_seq");			// Since object
			rd_seq.start(v_sqr.rd_sqr);
		end

		if(starting_phase!=null)
			starting_phase.drop_objection(this);
		`uvm_info(get_type_name(),"Inside body task of sync_fifo_v_seq",UVM_HIGH)
	endtask: body
endclass: sync_fifo_v_seq

class sync_fifo_wr_rd_v_seq extends sync_fifo_v_seq;
	`uvm_object_utils(sync_fifo_wr_rd_v_seq)
	`NEW_OBJECT

	virtual task body();
		if(!$cast(v_sqr,m_sequencer))
			`uvm_fatal(get_full_name(),"!!!! Casting failed in sync_fifo_wr_rd_v_seq !!!!")

		wr_seq = sync_fifo_wr_seq::type_id::create("wr_seq");
		rd_seq = sync_fifo_rd_seq::type_id::create("rd_seq");

		if(starting_phase!=null)
			starting_phase.raise_objection(this);
		fork
			wr_seq.start(v_sqr.wr_sqr);
			#10 rd_seq.start(v_sqr.rd_sqr);
		join
		if(starting_phase!=null)
			starting_phase.drop_objection(this);

		`uvm_info(get_type_name(),"Inside body task of sync_fifo_wr_rd_v_seq",UVM_HIGH)
	endtask: body
endclass: sync_fifo_wr_rd_v_seq
