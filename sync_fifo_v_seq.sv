class sync_fifo_v_seq extends uvm_sequence#(uvm_sequence_item);
//Factory registration
	`uvm_object_utils(sync_fifo_v_seq)
//Constructor
	`NEW_OBJECT

//Properties
//	uvm_phase starting_phase;

//v_sqr, base_seq instantiation
	sync_fifo_v_sqr v_sqr;
	sync_fifo_wr_seq wr_seq;
	sync_fifo_rd_seq rd_seq;
	sync_fifo_wr_agent_config wr_cfg;
	sync_fifo_rd_agent_config rd_cfg;

//body task
	virtual task body();
		//m_sequencer=env.v_sqr; //built-in
		`uvm_info(get_type_name(),
			"Inside body task of sync_fifo_v_seq",
			UVM_HIGH)

		if(!$cast(v_sqr,m_sequencer))
			`uvm_error(get_type_name(),"!!!! Casting failed in sync_fifo_v_seq !!!!")

		`uvm_info(get_type_name(),
			$sformatf(">>>> v_sqr type = %0s, instance name = %0s <<<<", v_sqr.get_type_name(), v_sqr.get_full_name()),
			UVM_DEBUG)
		`uvm_info(get_type_name(),
			$sformatf(">>>> m_sequencer type = %0s, instance name = %0s <<<<", m_sequencer.get_type_name(), m_sequencer.get_full_name()),
			UVM_DEBUG)

		if(!uvm_config_db#(sync_fifo_wr_agent_config)::get(null,"","WR_CFG",wr_cfg))
			`uvm_error(get_type_name(),"!!!! Unable to get wr_cfg in sync_fifo_v_seq !!!!")
		if(!uvm_config_db#(sync_fifo_rd_agent_config)::get(null,"","RD_CFG",rd_cfg))
			`uvm_error(get_type_name(),"!!!! Unable to get rd_cfg in sync_fifo_v_seq !!!!")

//		if(starting_phase!=null)
//			starting_phase.raise_objection(this);

		fork
			if(wr_cfg.is_active==UVM_ACTIVE)begin
				wr_seq = sync_fifo_wr_seq::type_id::create("wr_seq");			// Since object
				`UVM_NULL_CHECK(wr_seq,get_type_name())
				`uvm_info(get_type_name(),
					"Created wr_seq and starting it on v_sqr.wr_sqr",
					UVM_HIGH)
				wr_seq.start(v_sqr.wr_sqr);
			end
			if(rd_cfg.is_active==UVM_ACTIVE)begin
				rd_seq = sync_fifo_rd_seq::type_id::create("rd_seq");			// Since object
				`UVM_NULL_CHECK(rd_seq,get_type_name())
				`uvm_info(get_type_name(),
					"Created rd_seq and starting it on v_sqr.rd_sqr",
					UVM_HIGH)
				rd_seq.start(v_sqr.rd_sqr);
			end
		join

//		if(starting_phase!=null)
//			starting_phase.drop_objection(this);
	endtask: body
endclass: sync_fifo_v_seq

class sync_fifo_wr_rd_v_seq extends sync_fifo_v_seq;
	`uvm_object_utils(sync_fifo_wr_rd_v_seq)
	`NEW_OBJECT

	virtual task body();
		`uvm_info(get_type_name(),
			"Inside body task of sync_fifo_wr_rd_v_seq",
			UVM_HIGH)

		if(!$cast(v_sqr,m_sequencer))
			`uvm_error(get_type_name(),"!!!! Casting failed in sync_fifo_wr_rd_v_seq !!!!")

		`uvm_info(get_type_name(),
			$sformatf(">>>> v_sqr type = %0s, instance name = %0s <<<<", v_sqr.get_type_name(), v_sqr.get_full_name()),
			UVM_DEBUG)
		`uvm_info(get_type_name(),
			$sformatf(">>>> m_sequencer type = %0s, instance name = %0s <<<<", m_sequencer.get_type_name(), m_sequencer.get_full_name()),
			UVM_DEBUG)

		wr_seq = sync_fifo_wr_seq::type_id::create("wr_seq");
		rd_seq = sync_fifo_rd_seq::type_id::create("rd_seq");

		`UVM_NULL_CHECK(wr_seq,get_type_name())
		`UVM_NULL_CHECK(rd_seq,get_type_name())

		fork
			wr_seq.start(v_sqr.wr_sqr);
			#10 rd_seq.start(v_sqr.rd_sqr);
		join
	endtask: body
endclass: sync_fifo_wr_rd_v_seq
