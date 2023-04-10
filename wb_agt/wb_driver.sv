class wb_driver extends uvm_driver#(wb_xtn);
	
	`uvm_component_utils(wb_driver)

	wb_agt_config cfg;

	virtual wb_if.WB_DRIV vif;

	function new(string name="wb_driver",uvm_component parent=null);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		
		if(!uvm_config_db#(wb_agt_config)::get(this,"","wb_agt_config",cfg))
			`uvm_fatal("AGT_CONFIG","Cannot get() env_cfg from config database. Have you set() it")

	  	super.build_phase(phase);
	endfunction

	function void connect_phase(uvm_phase phase);
		vif=cfg.vif;
	endfunction

	task run_phase(uvm_phase phase);
		@(vif.wb_driv);
		while (vif.wb_driv.rst == 1) @(vif.wb_driv);

		vif.wb_driv.wb_cyc_i<=1'b0;
        vif.wb_driv.wb_stb_i<=1'b0;		

		forever begin
			seq_item_port.get_next_item(req);

			drive_item(req);
				
			seq_item_port.item_done();

		end
	endtask

	task drive_item(wb_xtn xtn);
		
		@(vif.wb_driv);
		
		vif.wb_driv.wb_dat_i<=xtn.wb_dat;
		vif.wb_driv.wb_addr_i<=xtn.wb_addr;
		vif.wb_driv.wb_we_i<=xtn.wb_we;
		//@(vif.wb_driv);	
		vif.wb_driv.wb_stb_i<=1'b1;
		vif.wb_driv.wb_cyc_i<=1'b1;
		vif.wb_driv.wb_sel_i<=4'b0001;
			
		wait(vif.wb_driv.wb_ack_o);
		
		//@(vif.wb_driv);
		vif.wb_driv.wb_cyc_i<=1'b0;
		vif.wb_driv.wb_stb_i<=1'b0;
	endtask

endclass


