class uart_env extends uvm_env;
	`uvm_component_utils(uart_env)
		
	uart_agt_top agt_top;
	
	uart_env_config env_cfg;

	virtual_sequencer vsqrh;

	uart_scoreboard sb;
	
	function new(string name="uart_env",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		
		super.build_phase(phase);
		
		if(!uvm_config_db#(uart_env_config)::get(this,"","uart_env_config",env_cfg))
			`uvm_fatal("ENV_CONFIG","Cannot get() env_config from config database. Have you set() it?")
		if(env_cfg.has_wb_agent)
			agt_top=uart_agt_top::type_id::create("agt_top",this);
		if(env_cfg.has_virtual_sequencer)
			vsqrh=virtual_sequencer::type_id::create("vsqrh",this);

		if(env_cfg.has_scoreboard)
			sb=uart_scoreboard::type_id::create("sb",this);
	endfunction

	function void  connect_phase(uvm_phase phase);
			
			super.connect_phase(phase);
	
			if(env_cfg.has_virtual_sequencer)
				begin
					if(env_cfg.has_wb_agent)
					begin
						foreach(agt_top.agt[i])
							vsqrh.agt_vsqrh[i]=agt_top.agt[i].sqrh;
					end
				end
			if(env_cfg.has_scoreboard)
				begin
					foreach(sb.fifo_h[i])	
						agt_top.agt[i].monh.monitor_port.connect(sb.fifo_h[i].analysis_export);
				end


	endfunction
endclass


	
