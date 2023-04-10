class uart_env_config extends uvm_object;
	`uvm_object_utils(uart_env_config)
	
	bit has_wb_agent=1;

	bit has_virtual_sequencer=1;
	bit has_scoreboard=1;
	
	wb_agt_config agt_config[];

	int no_of_agts=2;

	extern function new(string name="uart_env_config");

    //REGISTERS LIST

	bit [7:0] thr[$];
	bit [7:0] rb[$];
	bit [7:0] ier;
	bit [7:0] iir;
    bit [7:0] fcr;
	bit [7:0] lcr;
	bit [7:0] lsr;
	bit [7:0] dlr_1;
	bit [7:0] dlr_2;
	bit [7:0] mcr;

endclass

function uart_env_config::new(string name="uart_env_config");
	super.new(name);
endfunction



	

