class wb_agt extends uvm_agent;
  `uvm_component_utils(wb_agt)

  wb_driver    drvh;
  wb_sequencer sqrh;
  wb_monitor   monh;
  wb_agt_config  cfg;
  
  function new(string name="wb_agt",uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db#(wb_agt_config)::get(this,"","wb_agt_config",cfg)) begin
      `uvm_fatal("AGT_CONFIG","Cannot get cfg from config database. Have you set() it?")
    end

    uvm_config_db#(wb_agt_config)::set(this, "monh", "wb_agt_config", cfg);
    monh=wb_monitor::type_id::create("monh",this);

    if(cfg.is_active == UVM_ACTIVE) begin
      `uvm_info(get_type_name(), "agent is active", UVM_MEDIUM)
      uvm_config_db#(wb_agt_config)::set(this, "drvh", "wb_agt_config", cfg);
      sqrh=wb_sequencer::type_id::create("sqrh",this);
      drvh=wb_driver::type_id::create("drvh",this);
    end

  endfunction

  function void connect_phase(uvm_phase phase);
    if(cfg.is_active == UVM_ACTIVE)
      begin
        drvh.seq_item_port.connect(sqrh.seq_item_export);
      end
  endfunction
endclass


