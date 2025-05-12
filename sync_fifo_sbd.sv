`uvm_analysis_imp_decl(_wr)
`uvm_analysis_imp_decl(_rd)
class sync_fifo_sbd extends uvm_scoreboard;
//Factory registration
	`uvm_component_utils(sync_fifo_sbd)

//Constructor
	`NEW_COMPONENT

//Port declaration
	uvm_analysis_imp_wr#(sync_fifo_wr_seq_item,sync_fifo_sbd) wr_imp;
	uvm_analysis_imp_rd#(sync_fifo_rd_seq_item,sync_fifo_sbd) rd_imp;

//Seq_items
	sync_fifo_wr_seq_item wr_tx;
	sync_fifo_rd_seq_item rd_tx;

//Properties
	bit wr_flag, rd_flag;
	bit [WIDTH-1:0] temp;
	bit [WIDTH-1:0] fifo[$];

//build_phase
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		wr_imp=new("wr_imp",this);
		rd_imp=new("rd_imp",this);
		`uvm_info("SYNC_FIFO_SBD","Inside build_phase of sync_fifo_sbd",UVM_HIGH)
	endfunction: build_phase

//run_phase
	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever begin
			wait(wr_flag || rd_flag);
			fork
				if(wr_tx.wr_en && !wr_tx.wr_err)begin
					fifo.push_back(wr_tx.wdata);
				end
				if(rd_tx.rd_en && !rd_tx.rd_err)begin
					temp = fifo.pop_front();
					if(rd_tx.rdata == temp) sync_fifo_common::match_count++;
					else sync_fifo_common::mismatch_count++;
				end
			join
		end
	endtask: run_phase

//write method
	virtual function void write_wr(sync_fifo_wr_seq_item wr_t);
		$cast(wr_tx,wr_t);
		wr_flag=1;
	endfunction: write_wr

	virtual function void write_rd(sync_fifo_rd_seq_item rd_t);
		$cast(rd_tx,rd_t);
		rd_flag=1;
	endfunction: write_rd
endclass: sync_fifo_sbd
