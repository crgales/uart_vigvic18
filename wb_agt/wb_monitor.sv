class wb_monitor extends uvm_monitor;
  
  `uvm_component_utils(wb_monitor)

  virtual wb_if.WB_MON vif;

  wb_agt_config agt_cfg;
  
  wb_xtn xtn;
  
  uvm_analysis_port#(wb_xtn) monitor_port;

  function new(string name="wb_monitor",uvm_component parent=null);
    
    super.new(name,parent);

    monitor_port=new("monitor_port",this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db#(wb_agt_config)::get(this,"","wb_agt_config",agt_cfg))
    `uvm_fatal("AGT_CONFIG","Cannot get() agt_cfg from config database. Have you set() it?")
  endfunction
  
  function void connect_phase(uvm_phase phase);
      
      vif=agt_cfg.vif;
  endfunction



  task run_phase(uvm_phase phase);
    xtn=wb_xtn::type_id::create("xtn");    
    forever begin
      collect_data();
    end
  endtask
  
  task collect_data();
    
    @(vif.wb_mon);
    
    wait(vif.wb_mon.wb_ack_o);
    xtn=wb_xtn::type_id::create("xtn");
  
    xtn.wb_addr   = vif.wb_mon.wb_addr_i;
    xtn.wb_we     = vif.wb_mon.wb_we_i;

    if (xtn.wb_we == 1'b1) xtn.wb_dat = vif.wb_mon.wb_dat_i;
    else xtn.wb_dat = vif.wb_mon.wb_dat_o;

    `uvm_info(get_full_name(),xtn.convert2string(),UVM_LOW);

    monitor_port.write(xtn);
  endtask

      
endclass
      
  
