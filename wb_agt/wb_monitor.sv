class uart_monitor extends uvm_monitor;
	
	`uvm_component_utils(uart_monitor)

	virtual wb_if.WB_MON vif;

	wb_agt_config agt_cfg;
   
        uart_xtn xtn;
	uvm_analysis_port#(uart_xtn) monitor_port;

	function new(string name="uart_monitor",uvm_component parent);
		
		super.new(name,parent);

		monitor_port=new("monitor_port",this);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(!uvm_config_db#(wb_agt_config)::get(this,"","wb_agt_config",agt_cfg))
		`uvm_fatal("AGT_CONFIG","Cannot get() agt_cfg from config database. Have you set() it?")
	endfunction
	
	function void connect_phase(uvm_phase phase);
			
			vif=agt_cfg.vif;
	endfunction



	task run_phase(uvm_phase phase);
		xtn=uart_xtn::type_id::create("xtn");		
		forever begin
			collect_data();
		end
	endtask
	
	task collect_data();
		
		//xtn=uart_xtn::type_id::create("xtn");
		@(vif.wb_mon);
		
		wait(vif.wb_mon.wb_ack_o);
	
		

			xtn.wb_addr_i 	= vif.wb_mon.wb_addr_i;
			xtn.wb_we_i     = vif.wb_mon.wb_we_i;

			if(xtn.wb_addr_i == 3 && xtn.wb_we_i == 1)

					xtn.lcr = vif.wb_mon.wb_dat_i;
			if(xtn.wb_addr_i == 1  && xtn.wb_we_i == 1 && xtn.lcr[7] ==1)
					xtn.dlr_1  = vif.wb_mon.wb_dat_i;

			if(xtn.wb_addr_i == 0  && xtn.wb_we_i ==1 && xtn.lcr[7]==1)
					xtn.dlr_2  = vif.wb_mon.wb_dat_i;

			/*if(xtn.wb_addr_i == 0 && xtn.wb_we_i == 0 && xtn.lcr[7] == 0)
					xtn.rb.push_back(vif.wb_mon.wb_dat_o);*/

			if(xtn.wb_addr_i == 1  && xtn.wb_we_i == 1)

					xtn.ier  =  vif.wb_mon.wb_dat_i;

			if(xtn.wb_addr_i == 2 && xtn.wb_we_i == 1)
					xtn.fcr = vif.wb_mon.wb_dat_i;


			if(xtn.wb_addr_i == 0 && xtn.wb_we_i == 1 && xtn.lcr[7] == 0)
					xtn.thr.push_back(vif.wb_mon.wb_dat_i);


			if(xtn.wb_addr_i == 0 && xtn.wb_we_i == 0 &&  xtn.lcr[7] == 0)
					xtn.rb.push_back(vif.wb_mon.wb_dat_o);
				
			if(xtn.wb_addr_i == 2 && xtn.wb_we_i == 1)
					xtn.fcr = vif.wb_mon.wb_dat_i;
			if(xtn.wb_addr_i == 2 && xtn.wb_we_i == 0)
					begin
						wait(vif.wb_mon.wb_int_o)
							xtn.iir = vif.wb_mon.wb_dat_o;		

					end
			


			`uvm_info("MONITOR",$sformatf("Printing from monitor /n %s",xtn.sprint),UVM_LOW)

			monitor_port.write(xtn);
	endtask

			
endclass
			
	
