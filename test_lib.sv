class base_test extends uvm_test;
//Factory registration
	`uvm_component_utils(base_test)

//Constructor
	`NEW_COMPONENT

//env handle
	sync_fifo_env env;

//Env & Agent config handles
	sync_fifo_env_config env_cfg;

//build_phase
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info(get_type_name(),
			"Inside build_phase of base_test",
			UVM_HIGH)

//Set env_cfg only if it's not set by the child class
		if(!uvm_config_db#(sync_fifo_env_config)::get(this,"env","ENV_CFG",env_cfg))begin
			`uvm_info(get_type_name(),
				"Didn't set env_cfg in child class",
				UVM_HIGH)
			env_cfg = sync_fifo_env_config::type_id::create("env_cfg");
			env_cfg_set		(1,1);
			agent_cfg_set	(1,1);
		end
		`uvm_info(get_type_name(),
			$sformatf(">>>> %0t Before creating object for env <<<<",$time),
			UVM_DEBUG)

		env	= sync_fifo_env::type_id::create("env",this);
		`UVM_NULL_CHECK(env,get_type_name())
	endfunction: build_phase

//end_of_elaboration_phase
	virtual function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		`uvm_info(get_type_name(),
			"Inside end_of_elaboration_phase of base_test",
			UVM_HIGH)
		uvm_factory::get().print();
		uvm_top.print_topology();
	endfunction: end_of_elaboration_phase

//report_phase
	virtual function void report_phase(uvm_phase phase);
		super.report_phase(phase);
		`uvm_info(get_type_name(),
			"Inside report_phase of base_test",
			UVM_HIGH)
	endfunction: report_phase

	extern function void env_cfg_set	(input bit wr_sub,	input bit rd_sub);
	extern function void agent_cfg_set	(input bit wr,		input bit rd);
endclass: base_test

//Override the base sequences handles and start v_seq on v_sqr
/********************* Test-1(Single Write) ******************************/
class write_test extends base_test;
	`uvm_component_utils(write_test)
	`NEW_COMPONENT

	sync_fifo_v_seq v_seq;

	virtual function void build_phase(uvm_phase phase);
		`uvm_info(get_type_name(),
			"Inside build_phase of write_test",
			UVM_HIGH)

		sync_fifo_wr_seq::type_id::set_type_override(write_seq::get_type());
		`uvm_info(get_type_name(),
			$sformatf(">>>> Overrode sync_fifo_wr_seq with %0s <<<<",write_seq::get_type().get_type_name()),
			UVM_DEBUG)

		env_cfg = sync_fifo_env_config::type_id::create("env_cfg");
		`UVM_NULL_CHECK(env_cfg,get_type_name())
		
		`uvm_info(get_type_name(),
			">>>> Setting env_cfg & agent cfgs from write_test's build_phase <<<<",
			UVM_DEBUG)

		env_cfg_set		(1,0);
		agent_cfg_set	(1,0);
		super.build_phase(phase);
	endfunction: build_phase

	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);
      	`uvm_info(get_type_name(),
			"Inside run_phase of write_test",
			UVM_HIGH)

		`uvm_info(get_type_name(),"****************************",UVM_LOW)
		`uvm_info(get_type_name(),"*****Running write_test*****",UVM_LOW)
		`uvm_info(get_type_name(),"****************************",UVM_LOW)

		phase.raise_objection(this,$sformatf("@@@ Raised objection at line %0d in %0s @@@",`__LINE__,`__FILE__));

		v_seq=sync_fifo_v_seq::type_id::create("sync_fifo_v_seq");
		`UVM_NULL_CHECK(v_seq,get_type_name())
		
		if(v_seq) begin
//			v_seq.starting_phase = phase;
			`uvm_info(get_type_name(),
				"***********Starting v_seq on v_sqr***********",
				UVM_LOW)
			v_seq.start(env.v_sqr);
		end

		phase.phase_done.set_drain_time(this,20);
		phase.drop_objection(this,$sformatf("@@@ Dropped objection at line %0d in %0s @@@",`__LINE__,`__FILE__));
	endtask: run_phase
endclass: write_test
/****************************************************************************/
/************************ Test-2(Burst4 Write) ******************************/
class burst4_write_test extends base_test;
	`uvm_component_utils(burst4_write_test)
	`NEW_COMPONENT

	sync_fifo_v_seq v_seq;

	virtual function void build_phase(uvm_phase phase);
		`uvm_info(get_type_name(),
			"Inside build_phase of burst4_write_test",
			UVM_HIGH)

		sync_fifo_wr_seq::type_id::set_type_override(burst4_write_seq::get_type());
		`uvm_info(get_type_name(),
			$sformatf(">>>> Overrode sync_fifo_wr_seq with %0s <<<<",burst4_write_seq::get_type().get_type_name()),
			UVM_DEBUG)

		env_cfg = sync_fifo_env_config::type_id::create("env_cfg");
		`UVM_NULL_CHECK(env_cfg,get_type_name())
		
		`uvm_info(get_type_name(),
			">>>> Setting env_cfg & agent cfgs from burst4_write_test's build_phase <<<<",
			UVM_DEBUG)

		env_cfg_set		(1,0);
		agent_cfg_set	(1,0);
		super.build_phase(phase);
	endfunction: build_phase

	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);
      	`uvm_info(get_type_name(),
			"Inside run_phase of burst4_write_test",
			UVM_HIGH)

		`uvm_info(get_type_name(),"***********************************",UVM_LOW)
		`uvm_info(get_type_name(),"*****Running burst4_write_test*****",UVM_LOW)
		`uvm_info(get_type_name(),"***********************************",UVM_LOW)

		phase.raise_objection(this,$sformatf("@@@ Raised objection at line %0d in %0s @@@",`__LINE__,`__FILE__));

		v_seq=sync_fifo_v_seq::type_id::create("sync_fifo_v_seq");
		`UVM_NULL_CHECK(v_seq,get_type_name())
		
		if(v_seq) begin
//			v_seq.starting_phase = phase;
			`uvm_info(get_type_name(),
				"***********Starting v_seq on v_sqr***********",
				UVM_LOW)
			v_seq.start(env.v_sqr);
		end

		phase.phase_done.set_drain_time(this,20);
		phase.drop_objection(this,$sformatf("@@@ Dropped objection at line %0d in %0s @@@",`__LINE__,`__FILE__));
	endtask: run_phase
endclass: burst4_write_test
/****************************************************************************/
/************************ Test-3(Full Depth Write) ******************************/
class full_depth_write_test extends base_test;
	`uvm_component_utils(full_depth_write_test)
	`NEW_COMPONENT

	sync_fifo_v_seq v_seq;

	virtual function void build_phase(uvm_phase phase);
		`uvm_info(get_type_name(),
			"Inside build_phase of full_depth_write_test",
			UVM_HIGH)

		sync_fifo_wr_seq::type_id::set_type_override(full_depth_write_seq::get_type());
		`uvm_info(get_type_name(),
			$sformatf(">>>> Overrode sync_fifo_wr_seq with %0s <<<<",full_depth_write_seq::get_type().get_type_name()),
			UVM_DEBUG)

		env_cfg = sync_fifo_env_config::type_id::create("env_cfg");
		`UVM_NULL_CHECK(env_cfg,get_type_name())
		
		`uvm_info(get_type_name(),
			">>>> Setting env_cfg & agent cfgs from full_depth_write_test's build_phase <<<<",
			UVM_DEBUG)

		env_cfg_set		(1,0);
		agent_cfg_set	(1,0);
		super.build_phase(phase);
	endfunction: build_phase

	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);
      	`uvm_info(get_type_name(),
			"Inside run_phase of full_depth_write_test",
			UVM_HIGH)

		`uvm_info(get_type_name(),"*************************************",UVM_LOW)
		`uvm_info(get_type_name(),"****Running full_depth_write_test****",UVM_LOW)
		`uvm_info(get_type_name(),"*************************************",UVM_LOW)

		phase.raise_objection(this,$sformatf("@@@ Raised objection at line %0d in %0s @@@",`__LINE__,`__FILE__));

		v_seq=sync_fifo_v_seq::type_id::create("sync_fifo_v_seq");
		`UVM_NULL_CHECK(v_seq,get_type_name())
		
		if(v_seq) begin
//			v_seq.starting_phase = phase;
			`uvm_info(get_type_name(),
				"***********Starting v_seq on v_sqr***********",
				UVM_LOW)
			v_seq.start(env.v_sqr);
		end

		phase.phase_done.set_drain_time(this,20);
		phase.drop_objection(this,$sformatf("@@@ Dropped objection at line %0d in %0s @@@",`__LINE__,`__FILE__));
	endtask: run_phase
endclass: full_depth_write_test
/****************************************************************************/
/******************** Test-3(Single Write & Read) ***************************/
class wr_rd_test extends base_test;
	`uvm_component_utils(wr_rd_test)
	`NEW_COMPONENT

	sync_fifo_wr_rd_v_seq wr_rd_v_seq;

	virtual function void build_phase(uvm_phase phase);
		`uvm_info(get_type_name(),
			"Inside build_phase of wr_rd_test",
			UVM_HIGH)

		sync_fifo_wr_seq::type_id::set_type_override(write_seq::get_type());
		sync_fifo_rd_seq::type_id::set_type_override(read_seq::get_type());

		`uvm_info(get_type_name(),
			$sformatf(">>>> Overrode sync_fifo_wr_seq with %0s <<<<",write_seq::get_type().get_type_name()),
			UVM_DEBUG)
		`uvm_info(get_type_name(),
			$sformatf(">>>> Overrode sync_fifo_rd_seq with %0s <<<<",read_seq::get_type().get_type_name()),
			UVM_DEBUG)

		env_cfg = sync_fifo_env_config::type_id::create("env_cfg");
		`UVM_NULL_CHECK(env_cfg,get_type_name())
		
		`uvm_info(get_type_name(),
			">>>> Setting env_cfg & agent cfgs from wr_rd_test's build_phase <<<<",
			UVM_DEBUG)

		env_cfg_set		(1,1);
		agent_cfg_set	(1,1);
		super.build_phase(phase);
	endfunction: build_phase

	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);

		`uvm_info(get_type_name(),"****************************",UVM_LOW)
		`uvm_info(get_type_name(),"*****Running wr_rd_test*****",UVM_LOW)
		`uvm_info(get_type_name(),"****************************",UVM_LOW)

		wr_rd_v_seq=sync_fifo_wr_rd_v_seq::type_id::create("wr_rd_v_seq");
		if(wr_rd_v_seq == null)
			`uvm_fatal(get_full_name(),"!!!! Creation of v_seq failed in wr_rd_test !!!!")
		else begin
			v_seq.starting_phase = phase;
			wr_rd_v_seq.start(env.v_sqr, phase);
		end
	endtask: run_phase
endclass: wr_rd_test
/****************************************************************************/

/******************************** env_cfg_set *******************************/
function void base_test::env_cfg_set(input bit wr_sub, input bit rd_sub);
	env_cfg.has_wr_subscriber = wr_sub;
	env_cfg.has_rd_subscriber = rd_sub;

	`uvm_info(get_type_name(),
		$sformatf(">>>> %0t Before setting env_cfg <<<<", $time),
		UVM_DEBUG)

	uvm_config_db#(sync_fifo_env_config)::set(this,"env","ENV_CFG",env_cfg);

	`uvm_info(get_type_name(),
		$sformatf(">>>> %0t After setting env_cfg <<<<", $time),
		UVM_DEBUG)
endfunction: base_test::env_cfg_set
/****************************************************************************/

/****************************** agent_cfg_set *******************************/
function void base_test::agent_cfg_set(input bit wr, input bit rd);
	env_cfg.wr_cfg.is_active=(wr==1) ? UVM_ACTIVE:UVM_PASSIVE;
	env_cfg.rd_cfg.is_active=(rd==1) ? UVM_ACTIVE:UVM_PASSIVE;

	`uvm_info(get_type_name(),
		$sformatf(">>>> %0t Before setting wr_cfg and rd_cfg <<<<", $time),
		UVM_DEBUG)

	uvm_config_db#(sync_fifo_wr_agent_config)::set(null,"*","WR_CFG",env_cfg.wr_cfg);
	uvm_config_db#(sync_fifo_rd_agent_config)::set(null,"*","RD_CFG",env_cfg.rd_cfg);

	`uvm_info(get_type_name(),
		$sformatf(">>>> %0t After setting wr_cfg and rd_cfg <<<<", $time),
		UVM_DEBUG)
endfunction: base_test::agent_cfg_set
/****************************************************************************/
