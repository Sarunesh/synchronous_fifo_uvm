class sync_fifo_rd_agent_config extends uvm_object;
	//Factory registration
	`uvm_object_utils(sync_fifo_rd_agent_config)

	//Constructor
	`NEW_OBJECT

	uvm_active_passive_enum is_active = UVM_ACTIVE;
endclass: sync_fifo_rd_agent_config
