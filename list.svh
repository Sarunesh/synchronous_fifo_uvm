`include "uvm_pkg.sv"
import uvm_pkg::*;
`include "sync_fifo_macros.svh"
`include "sync_fifo_common.sv"
import common_pkg::*;
`include "sync_fifo.v"
`include "sync_fifo_intf.sv"

//Class Forward Declarations
typedef class sync_fifo_wr_agent_config;
typedef class sync_fifo_rd_agent_config;
typedef class sync_fifo_env_config;
typedef class sync_fifo_env;
typedef class sync_fifo_rd_agent;
typedef class sync_fifo_rd_drv;
typedef class sync_fifo_rd_mon;
typedef class sync_fifo_rd_seq;
typedef class sync_fifo_rd_sqr;
typedef class sync_fifo_rd_sub;
typedef class sync_fifo_sbd;
typedef class sync_fifo_wr_seq_item;
typedef class sync_fifo_rd_seq_item;
typedef class sync_fifo_v_seq;
typedef class sync_fifo_v_sqr;
typedef class sync_fifo_wr_agent;
typedef class sync_fifo_wr_drv;
typedef class sync_fifo_wr_mon;
typedef class sync_fifo_wr_seq;
typedef class sync_fifo_wr_sqr;
typedef class sync_fifo_wr_sub;

`include "sync_fifo_wr_agent_config.sv"
`include "sync_fifo_rd_agent_config.sv"
`include "sync_fifo_env_config.sv"
`include "sync_fifo_env.sv"
`include "sync_fifo_rd_agent.sv"
`include "sync_fifo_rd_drv.sv"
`include "sync_fifo_rd_mon.sv"
`include "sync_fifo_rd_seq.sv"
`include "sync_fifo_rd_sqr.sv"
`include "sync_fifo_rd_sub.sv"
`include "sync_fifo_sbd.sv"
`include "sync_fifo_wr_seq_item.sv"
`include "sync_fifo_rd_seq_item.sv"
`include "sync_fifo_v_seq.sv"
`include "sync_fifo_v_sqr.sv"
`include "sync_fifo_wr_agent.sv"
`include "sync_fifo_wr_drv.sv"
`include "sync_fifo_wr_mon.sv"
`include "sync_fifo_wr_seq.sv"
`include "sync_fifo_wr_sqr.sv"
`include "sync_fifo_wr_sub.sv"
`include "test_lib.sv"
`include "top.sv"
