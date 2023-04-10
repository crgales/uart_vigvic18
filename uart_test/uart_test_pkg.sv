package uart_test_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import wb_agt_pkg::*;
  import uart_env_pkg::*;

  `include "reg_config.sv"
  `include "uart_seqs.sv"
  `include "virtual_seq.sv"
  `include "uart_vtest_lib.sv"
  
endpackage

