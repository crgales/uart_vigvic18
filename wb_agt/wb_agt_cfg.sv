class wb_agt_config extends uvm_object;

	`uvm_object_utils(wb_agt_config)

	virtual wb_if vif;

	uvm_active_passive_enum is_active;

	extern function new(string name="wb_agt_config");
endclass

function wb_agt_config::new(string name="wb_agt_config");
	super.new(name);
endfunction


