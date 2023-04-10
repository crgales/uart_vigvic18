package wb_agt_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  `include "wb_xtn.sv"
  `include "wb_agt_cfg.sv"
  `include "wb_driver.sv"
  `include "wb_monitor.sv"
  typedef uvm_sequencer#(wb_xtn) wb_sequencer;
  `include "wb_agt.sv"
endpackage