class uart_agt_top extends uvm_agent;
	`uvm_component_utils(uart_agt_top)
	uart_agt agt[];
	uart_env_config e_cfg;
	function new(string name="uart_agt_top",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(uart_env_config)::get(this,"","uart_env_config",e_cfg))
			`uvm_fatal("ENV_CONFIG","Cannot get() e_cfg from config database. Have you set() it?")
		
	
		if(e_cfg.has_wb_agent)
		begin
			agt=new[e_cfg.no_of_agts];
			foreach(agt[i])
			begin
				agt[i]=uart_agt::type_id::create($sformatf("uart_agt[%0d]",i),this);
				uvm_config_db#(wb_agt_config)::set(this,$sformatf("uart_agt[%0d]*",i),"wb_agt_config",e_cfg.agt_config[i]);
				
				
				//	`uvm_fatal("AGT_CONFIG","Cannot get() agt_config from config database. Have you set() it?")
			end
		
			
			
		end	
	endfunction
endclass


