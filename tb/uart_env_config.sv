class uart_env_config extends uvm_object;
		`uvm_object_utils(uart_env_config)

	
	bit has_wb_agent;


	bit has_virtual_sequencer=1;

//	bit has_virtual_inf=2;

	bit has_scoreboard;
	
	wb_agt_config agt_config[];


	int no_of_duts;
	
	int no_of_agts=2;

	extern function new(string name="uart_env_config");

endclass

function uart_env_config::new(string name="uart_env_config");
	super.new(name);
endfunction



	

