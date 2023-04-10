class uart_driver extends uvm_driver#(uart_xtn);
	
	`uvm_component_utils(uart_driver)

	wb_agt_config cfg;

	virtual wb_if.WB_DRIV vif;

	extern  function new(string name="uart_driver",uvm_component parent);
	
	extern  function void build_phase(uvm_phase phase);

	extern function void connect_phase(uvm_phase phase);


	extern task run_phase(uvm_phase phase);
	
	extern task drive_item(uart_xtn xtn);

endclass


	function uart_driver::new(string name="uart_driver",uvm_component parent);
		super.new(name,parent);
	endfunction

	function void uart_driver::build_phase(uvm_phase phase);
		
		if(!uvm_config_db#(wb_agt_config)::get(this,"","wb_agt_config",cfg))
			`uvm_fatal("AGT_CONFIG","Cannot get() env_cfg from config database. Have you set() it")

	  	super.build_phase(phase);
	endfunction

	function void uart_driver::connect_phase(uvm_phase phase);
		vif=cfg.vif;
	endfunction

	task uart_driver::run_phase(uvm_phase phase);




	
		vif.wb_driv.wb_rst_i<=1;
			repeat(2) @(vif.wb_driv);
		//@(vif.wb_driv);
		vif.wb_driv.wb_rst_i<=0;
		vif.wb_driv.wb_cyc_i<=1'b0;
                vif.wb_driv.wb_stb_i<=1'b0;		

		forever
			begin
				
				seq_item_port.get_next_item(req);

				drive_item(req);
				
				seq_item_port.item_done();

			end
	endtask

	task uart_driver::drive_item(uart_xtn xtn);
		
		@(vif.wb_driv);
		
			vif.wb_driv.wb_dat_i<=xtn.wb_dat_i;
			vif.wb_driv.wb_addr_i<=xtn.wb_addr_i;
			vif.wb_driv.wb_we_i<=xtn.wb_we_i;
		//@(vif.wb_driv);	
			vif.wb_driv.wb_stb_i<=1'b1;
			vif.wb_driv.wb_cyc_i<=1'b1;
			vif.wb_driv.wb_sel_i<=4'b0001;
	

		
		wait(vif.wb_driv.wb_ack_o);
		

			//@(vif.wb_driv);

			vif.wb_driv.wb_cyc_i<=1'b0;
			vif.wb_driv.wb_stb_i<=1'b0;
		if(xtn.wb_addr_i == 2 && xtn.wb_we_i == 0)
			begin
					
					wait(vif.wb_driv.wb_int_o)
					
					@(vif.wb_driv);
		
						xtn.wb_dat_o= vif.wb_driv.wb_dat_o;
					
						seq_item_port.put_response(xtn);
						
						$display("The Value of IIR is %0b",xtn.wb_dat_o);
					
			end


	endtask

//endclass

