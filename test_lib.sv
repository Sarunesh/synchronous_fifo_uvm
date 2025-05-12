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

		//Set env_cfg only if it's not set by the child class
		if(!uvm_config_db#(sync_fifo_env_config)::get(this,"env","ENV_CFG",env_cfg))begin
			env_cfg = sync_fifo_env_config::type_id::create("env_cfg");
			env_cfg_set(1,1);
			agent_cfg_set(1,1);
		end

		env		= sync_fifo_env::type_id::create("env",this);
		`uvm_info(get_type_name(),"Inside build_phase of base_test",UVM_HIGH)
	endfunction: build_phase

	//end_of_elaboration_phase
	virtual function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		uvm_top.print_topology();
		`uvm_info(get_type_name(),"Inside end_of_elaboration_phase of base_test",UVM_HIGH)
	endfunction: end_of_elaboration_phase

	//report_phase
	virtual function void report_phase(uvm_phase phase);
		super.report_phase(phase);
		`uvm_info(get_type_name(),"Inside report_phase of base_test",UVM_HIGH)
	endfunction: report_phase

	extern function void env_cfg_set(input bit wr_sub, input bit rd_sub);
	extern function void agent_cfg_set(input bit wr, input bit rd);
endclass: base_test

//Override the base sequences handles and start v_seq on v_sqr
/********************* Test-1(Single Write) ******************************/
class write_test extends base_test;
	`uvm_component_utils(write_test)
	`NEW_COMPONENT

	sync_fifo_v_seq v_seq;

	virtual function void build_phase(uvm_phase phase);
		sync_fifo_wr_seq::type_id::set_type_override(write_seq::get_type());
		env_cfg = sync_fifo_env_config::type_id::create("env_cfg");
		env_cfg_set(1,0);
		agent_cfg_set(1,0);
		super.build_phase(phase);
	endfunction: build_phase

	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);

		`uvm_info(get_type_name(),"****************************",UVM_LOW)
		`uvm_info(get_type_name(),"*****Running write_test*****",UVM_LOW)
		`uvm_info(get_type_name(),"****************************",UVM_LOW)

		v_seq=sync_fifo_v_seq::type_id::create("sync_fifo_v_seq");
		if(v_seq == null)
			`uvm_fatal(get_full_name(),"!!!! Creation of v_seq failed in write_test !!!!")
		else begin
			v_seq.starting_phase = phase;
			v_seq.start(env.v_sqr);
		end
	endtask: run_phase
endclass: write_test
/****************************************************************************/

/******************** Test-2(Single Write & Read) ***************************/
/*class wr_rd_test extends base_test;
	`uvm_component_utils(wr_rd_test)
	`NEW_COMPONENT

	sync_fifo_wr_rd_v_seq wr_rd_v_seq;

	virtual function void build_phase(uvm_phase phase);
		env_cfg = sync_fifo_env_config::type_id::create("env_cfg");
		sync_fifo_wr_seq::type_id::set_type_override(write_seq::get_type());
		sync_fifo_rd_seq::type_id::set_type_override(read_seq::get_type());
		env_cfg_set(1,1);
		agent_cfg_set(1,1);
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
endclass: wr_rd_test */
/****************************************************************************/

/******************************** env_cfg_set *******************************/
function void base_test::env_cfg_set(input bit wr_sub, input bit rd_sub);
	env_cfg.has_wr_subscriber = wr_sub;
	env_cfg.has_rd_subscriber = rd_sub;

	uvm_config_db#(sync_fifo_env_config)::set(this,"env","ENV_CFG",env_cfg);
endfunction: base_test::env_cfg_set
/****************************************************************************/

/****************************** agent_cfg_set *******************************/
function void base_test::agent_cfg_set(input bit wr, input bit rd);
	env_cfg.wr_cfg.is_active=(wr==1) ? UVM_ACTIVE:UVM_PASSIVE;
	env_cfg.rd_cfg.is_active=(rd==1) ? UVM_ACTIVE:UVM_PASSIVE;

	uvm_config_db#(sync_fifo_wr_agent_config)::set(this,"env.wr_agent","WR_CFG",env_cfg.wr_cfg);
	uvm_config_db#(sync_fifo_rd_agent_config)::set(this,"env.rd_agent","RD_CFG",env_cfg.rd_cfg);
endfunction: base_test::agent_cfg_set
/****************************************************************************/
