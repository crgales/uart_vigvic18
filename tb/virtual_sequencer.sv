class virtual_sequencer extends uvm_sequencer#(uvm_sequence_item);

	`uvm_component_utils(virtual_sequencer)

	uart_env_config env_cfg;
	
	uart_sequencer agt_vsqrh[];

	function new(string name="virtual_sequencer",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		
		if(!uvm_config_db#(uart_env_config)::get(this,"","uart_env_config",env_cfg))
			`uvm_fatal("ENV_CONFIG","Cannot get() env_cfg from config database. Have you set() it?")
		
		agt_vsqrh=new[env_cfg.no_of_agts];
	endfunction
endclass


