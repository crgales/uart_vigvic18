class uart_agt extends uvm_agent;
	`uvm_component_utils(uart_agt)

	uart_driver    drvh;
	uart_sequencer sqrh;
	uart_monitor   monh;
	wb_agt_config  cfg;
	
	function new(string name="uart_agt",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(wb_agt_config)::get(this,"","wb_agt_config",cfg))

		`uvm_fatal("AGT_CONFIG","Cannot get cfg from config database. Have you set() it?")

		super.build_phase(phase);
		monh=uart_monitor::type_id::create("monh",this);
		if(cfg.is_active == UVM_ACTIVE)
			begin
			`uvm_info(get_type_name(), "agent is active", UVM_MEDIUM)
				sqrh=uart_sequencer::type_id::create("sqrh",this);
				drvh=uart_driver::type_id::create("drvh",this);
			end

	endfunction

	function void connect_phase(uvm_phase phase);
		if(cfg.is_active == UVM_ACTIVE)
			begin
				drvh.seq_item_port.connect(sqrh.seq_item_export);
			end
	endfunction
endclass


