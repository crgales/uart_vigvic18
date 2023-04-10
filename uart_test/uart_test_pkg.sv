package uart_test_pkg;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	`include "uart_xtn.sv"
	`include "wb_agt_cfg.sv"

	`include "uart_env_config.sv"
	`include "reg_config.sv"	
	`include "uart_driver.sv"
	`include "uart_monitor.sv"
	`include "uart_seqr.sv"
	`include "uart_seqs.sv"
     	`include "uart_agt.sv"
      	`include "uart_agt_top.sv"
	`include "virtual_sequencer.sv"
	`include "virtual_seq.sv"
	`include "uart_scoreboard.sv"	
	`include "uart_tb.sv"
	`include "uart_vtest_lib.sv"
	
	
endpackage

