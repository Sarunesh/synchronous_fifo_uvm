class sync_fifo_rd_sub extends uvm_subscriber#(sync_fifo_rd_seq_item);
//Factory registration
	`uvm_component_utils(sync_fifo_rd_sub)

//Covergroup
	covergroup rd_cg();
		type_option.comment="Read Subscriber";

		RD_EN_CP:coverpoint rd_tx.rd_en{
			bins RD_EN_HIGH = {1'b1};
			bins RD_EN_LOW = {1'b0};
		}
		RD_ERR_CP: coverpoint rd_tx.rd_err iff (rd_tx.rd_en);

		RD_EN_X_WR_ERR:cross RD_EN_CP, RD_ERR_CP;
	endgroup

//Constructor
	function new(string name="", uvm_component parent=null);
		super.new(name,parent);
		rd_cg=new();
	endfunction: new

//Properties
	sync_fifo_rd_seq_item rd_tx;

	virtual function void write(sync_fifo_rd_seq_item t);
		$cast(rd_tx,t);
		rd_cg.sample();
	endfunction: write
endclass: sync_fifo_rd_sub
