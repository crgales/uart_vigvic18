class uart_base_test extends uvm_test;
  
  `uvm_component_utils(uart_base_test)

  uart_env envh;
  uart_env_config env_config;
  
  wb_agt_config agt_config[];

  reg_config r_cfg;
 
  int no_of_agts = 2;
  
  int has_wb_agent=1;

  int has_scoreboard=1;

  function new(string name="uart_base_test",uvm_component parent);
    super.new(name,parent);
  endfunction

  function void  config_wb_agent(wb_agt_config cfg, int inst);
    string if_name = $sformatf("vif_%0d", inst);
          
    if(!uvm_config_db#(virtual wb_if)::get(this,"",if_name,cfg.vif))
      `uvm_fatal("VIF_CONFIG",$sformatf("Cannot get() interface %s from uvm_config_db. Have you set() it?", if_name))

    cfg.is_active = UVM_ACTIVE;

  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  
    env_config=uart_env_config::type_id::create("env_config");

    r_cfg=reg_config::type_id::create("r_cfg");

    env_config.agt_config=new[no_of_agts];

    foreach (env_config.agt_config[i]) begin
      env_config.agt_config[i]=wb_agt_config::type_id::create($sformatf("agt_config[%0d]",i));
      config_wb_agent(env_config.agt_config[i],i);
    end
    
    env_config.no_of_agts=no_of_agts;
    env_config.has_wb_agent= has_wb_agent;
    env_config.has_scoreboard=has_scoreboard;
    
    uvm_config_db#(reg_config)::set(this,"*","reg_config",r_cfg);
    uvm_config_db#(uart_env_config)::set(this,"envh","uart_env_config",env_config);

  //ENVIRONMENT CREATION//
    envh=uart_env::type_id::create("envh",this);

  endfunction

  function void assign_seq_handles(virtual_seq_base vseq);
    vseq.seqrh = new[2];
    vseq.seqrh[0] = envh.agt[0].sqrh;
    vseq.seqrh[1] = envh.agt[1].sqrh;
  endfunction

endclass

class TC1 extends uart_base_test;
  `uvm_component_utils(TC1)

  function new(string name="TC1",uvm_component parent);
      super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    v_seq1 vs1;
    
    phase.raise_objection(this);
      repeat(10) begin
        if (!r_cfg.randomize()) begin
          `uvm_fatal("RNDERR", "Unable to randomize config")
        end
        vs1=v_seq1::type_id::create("vs1");
        assign_seq_handles(vs1);
        vs1.start(null);
      end
      phase.drop_objection(this);
       
  endtask  

endclass



class TC2 extends uart_base_test;
  `uvm_component_utils(TC2)
  
  function new(string name="TC2",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    v_seq2 vs2;
    
    phase.raise_objection(this);
    repeat(10) begin
      if (!r_cfg.randomize()) begin
        `uvm_fatal("RNDERR", "Unable to randomize configuration")
      end
      vs2=v_seq2::type_id::create("vs2");
      assign_seq_handles(vs2);
      vs2.start(null);
    end
    phase.drop_objection(this);
  endtask
endclass


class TC3 extends uart_base_test;
  `uvm_component_utils(TC3)
  
  function new(string name="TC3",uvm_component parent);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    v_seq3 vs3;
    
    phase.raise_objection(this);
    
    vs3=v_seq3::type_id::create("vs3");
    assign_seq_handles(vs3);
    
    vs3.start(null);
    
    phase.drop_objection(this);
  endtask
endclass



