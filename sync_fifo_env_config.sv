class sync_fifo_env_config extends uvm_object;
	//Factory registration
	`uvm_object_utils(sync_fifo_env_config)

	sync_fifo_wr_agent_config wr_cfg;
	sync_fifo_rd_agent_config rd_cfg;
	bit has_wr_subscriber=1;
	bit has_rd_subscriber=1;

	//Constructor
	//`NEW_OBJECT
	function new(string name="sync_fifo_env_config");
		super.new(name);
		wr_cfg = sync_fifo_wr_agent_config::type_id::create("wr_cfg");
		rd_cfg = sync_fifo_rd_agent_config::type_id::create("rd_cfg");
	endfunction: new

endclass: sync_fifo_env_config
