class uart_env extends uvm_env;
  `uvm_component_utils(uart_env)
    
  wb_agt agt[2];
  
  uart_env_config env_cfg;

  uart_scoreboard sb;
  
  function new(string name="uart_env",uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    
    super.build_phase(phase);
    
    if(!uvm_config_db#(uart_env_config)::get(this,"","uart_env_config",env_cfg)) begin
      `uvm_fatal("ENV_CONFIG","Cannot get() env_config from config database. Have you set() it?")
    end

    uvm_config_db#(wb_agt_config)::set(this, "agt0", "wb_agt_config", env_cfg.agt_config[0]);
    uvm_config_db#(wb_agt_config)::set(this, "agt1", "wb_agt_config", env_cfg.agt_config[1]);

    agt[0] = wb_agt::type_id::create("agt0", this);
    agt[1] = wb_agt::type_id::create("agt1", this);
    
    uvm_config_db#(uart_env_config)::set(this, "sb", "uart_env_config", env_cfg);
    sb=uart_scoreboard::type_id::create("sb",this);
  endfunction

  function void  connect_phase(uvm_phase phase);
      
      super.connect_phase(phase);
  
      if(env_cfg.has_scoreboard) begin
        foreach(sb.fifo_h[i])  
          agt[i].monh.monitor_port.connect(sb.fifo_h[i].analysis_export);
      end
  endfunction
endclass


  
