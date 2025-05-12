class sync_fifo_wr_sub extends uvm_subscriber#(sync_fifo_wr_seq_item);
//Factory registration
	`uvm_component_utils(sync_fifo_wr_sub)

//Covergroup
	covergroup wr_cg;
		type_option.comment = "Write Subscriber";
		
		WR_EN_CP:coverpoint wr_tx.wr_en{
			bins WR_EN_HIGH = {1'b1};
			bins WR_EN_LOW = {1'b0};
		}
		WR_ERR_CP: coverpoint wr_tx.wr_err iff (wr_tx.wr_en);

		WR_EN_X_WR_ERR:cross WR_EN_CP, WR_ERR_CP;
	endgroup

//Constructor
	function new(string name="", uvm_component parent=null);
		super.new(name,parent);
		wr_cg=new();
	endfunction: new

//Properties
	sync_fifo_wr_seq_item wr_tx;

	virtual function void write(sync_fifo_wr_seq_item t);
		$cast(wr_tx,t);
		wr_cg.sample();
	endfunction: write
endclass: sync_fifo_wr_sub
