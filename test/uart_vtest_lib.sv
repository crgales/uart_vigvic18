class uart_base_test extends uvm_test;
	
	`uvm_component_utils(uart_base_test)

	uart_env envh;
	uart_env_config env_config;
	
	wb_agt_config agt_config[];

	reg_config r_cfg;
	
	int no_of_duts = 2; 
	
	int no_of_agts = 2;
	
	int  has_wb_agent=1;

	int has_scoreboard=1;
	
	
//	int has_virtual_inf=2;

	extern function new(string name="uart_base_test",uvm_component parent);

	extern function void  build_phase(uvm_phase phase);
	
	extern function void  config_uart();
	
//	extern function	void end_of_elaboration_phase(uvm_phase phase);

	extern function void report_phase(uvm_phase phase);


endclass

function uart_base_test::new(string name="uart_base_test",uvm_component parent);
	
		super.new(name,parent);
endfunction

function void  uart_base_test::config_uart();
	
	/*	if(has_wb_agent)
			begin
				
				agt_config=new[no_of_duts];
				
			foreach(agt_config[i])
				begin

					agt_config[i]=wb_agt_config::type_id::create($sformatf("agt_config[%0d]",i));

					if(!uvm_config_db#(virtual wb_if)::get(this," ","vif_",env_config.*/
		if(has_wb_agent)
			begin

				agt_config=new[no_of_duts];
			foreach(agt_config[i])
				begin

					agt_config[i]=wb_agt_config::type_id::create($sformatf("agt_config[%0d]",i));
					
					if(!uvm_config_db#(virtual wb_if)::get(this," ",$sformatf("vif_%0d",i),agt_config[i].vif))
						
						`uvm_fatal("VIF_CONFIG","Cannot get() interface vif from uvm_config_db. Have you set() it?")

					agt_config[i].is_active = UVM_ACTIVE;

					env_config.agt_config[i]=agt_config[i];

				end

			end
		
			env_config.no_of_agts=no_of_agts;
			env_config.no_of_duts=no_of_duts;
			env_config.has_wb_agent= has_wb_agent;
			env_config.has_scoreboard=has_scoreboard;
		

endfunction
				

function void uart_base_test::build_phase(uvm_phase phase);
	
		env_config=uart_env_config::type_id::create("env_config");

		r_cfg=reg_config::type_id::create("r_cfg");
		
	
		

		if(has_wb_agent)

			env_config.agt_config=new[no_of_duts];

		config_uart;

		uvm_config_db#(reg_config)::set(this,"*","reg_config",r_cfg);
		
		uvm_config_db#(uart_env_config)::set(this,"*","uart_env_config",env_config);

		super.build_phase(phase);

	//ENVIRONMENT CREATION//
		envh=uart_env::type_id::create("envh",this);


endfunction

/*function void  uart_base_test::end_of_elaboration_phase(uvm_phase phase);
	//	uvm_top.print_topology();
		print();
endfunction*/

function void uart_base_test::report_phase(uvm_phase phase);
		uvm_top.print_topology();
endfunction


class TC1 extends uart_base_test;
		`uvm_component_utils(TC1)

		v_seq1 vs1;
		
	


	function new(string name="TC1",uvm_component parent);
			super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
			super.build_phase(phase);
		
	endfunction

	task run_phase(uvm_phase phase);
					 
			phase.raise_objection(this);
			repeat(10)
			begin
				r_cfg.randomize();
				vs1=v_seq1::type_id::create("vs1");
				vs1.start(envh.vsqrh);
			end
			phase.drop_objection(this);
		   
	endtask	

endclass



class TC2 extends uart_base_test;
                `uvm_component_utils(TC2)

                v_seq2 vs2;




        function new(string name="TC2",uvm_component parent);
                        super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
                        super.build_phase(phase);
                       	
        endfunction

        task run_phase(uvm_phase phase);

                        phase.raise_objection(this);
			repeat(10)
			begin
				r_cfg.randomize();
                        	vs2=v_seq2::type_id::create("vs2");
                        	vs2.start(envh.vsqrh);
			end
                        phase.drop_objection(this);

        endtask

endclass


class TC3 extends uart_base_test;
                `uvm_component_utils(TC3)

                v_seq3 vs3;




        function new(string name="TC3",uvm_component parent);
                        super.new(name,parent);
        endfunction

        function void build_phase(uvm_phase phase);
                        super.build_phase(phase);

        endfunction

        task run_phase(uvm_phase phase);

                        phase.raise_objection(this);
                       	//repeat(10)
                        //begin
                               // r_cfg.randomize();
                                vs3=v_seq3::type_id::create("vs3");
                                vs3.start(envh.vsqrh);
                       	//end
                        phase.drop_objection(this);

        endtask

endclass



