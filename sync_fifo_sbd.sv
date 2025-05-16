class sync_fifo_sbd extends uvm_scoreboard;
//Factory Registration
	`uvm_component_utils(sync_fifo_sbd)

//Constructor
	`NEW_COMPONENT

//TLM FIFOs for analysis ports
	uvm_tlm_analysis_fifo #(sync_fifo_wr_seq_item) wr_fifo;
	uvm_tlm_analysis_fifo #(sync_fifo_rd_seq_item) rd_fifo;

//Properties
	bit [WIDTH-1:0] fifo[$];
	bit [WIDTH-1:0] temp;

//Build Phase
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info(get_type_name(),
			"Inside build_phase of sync_fifo_sbd",
			UVM_HIGH)
		
		wr_fifo = new("wr_fifo", this);
		rd_fifo = new("rd_fifo", this);
	endfunction
	
//Run Phase
	virtual task run_phase(uvm_phase phase);
		super.run_phase(phase);
		fork
//Write transaction handler
			forever begin
				sync_fifo_wr_seq_item wr_tx;
				wr_fifo.get(wr_tx);
				if (wr_tx.wr_en && !wr_tx.wr_err) begin
					fifo.push_back(wr_tx.wdata);
					`uvm_info(get_type_name(),
						$sformatf("Pushed: %0h", wr_tx.wdata),
						UVM_MEDIUM)
				end
			end
			
//Read transaction handler
			forever begin
				sync_fifo_rd_seq_item rd_tx;
				rd_fifo.get(rd_tx);
				if (rd_tx.rd_en && !rd_tx.rd_err) begin
					if (fifo.size() > 0) begin
						temp = fifo.pop_front();
						if (rd_tx.rdata == temp) sync_fifo_common::match_count++;
						else sync_fifo_common::mismatch_count++;
					end
				else
					`uvm_warning(get_type_name(),
						"Read attempted from empty model FIFO")
				end
			end
		join
	endtask
endclass : sync_fifo_sbd
