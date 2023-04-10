class uart_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(uart_scoreboard)

	uvm_tlm_analysis_fifo #(uart_xtn) fifo_h[];

	uart_env_config env_cfg;

	uart_xtn xtn1,xtn2;

	uart_xtn cov_data;
	
	int thr1size,thr2size,rb1size,rb2size;

	extern function new(string name="uart_scoreboard",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	
	extern task  run_phase(uvm_phase phase);

	extern function void check_phase(uvm_phase phase);	

	/*covergroup uart_signals_cov;
		option.per_instance=1;
	
		DATA:coverpoint cov_data.wb_dat_i[7:0] {bins wb_dat_i={[0:255]};}
		ADDRESS:coverpoint cov_data.wb_addr_i[2:0] {bins wb_addr_i={[0:7]};}
		ENABLE:coverpoint cov_data.wb_we_i {bins read={0};
						    bins writee={1};}
	endgroup*/

	covergroup uart_lcr_cov;
		option.per_instance=1;
		
		CHAR_SIZE:coverpoint cov_data.lcr[1:0] {bins five={2'b00};
							bins six={2'b01};
							bins seven={2'b10};
							bins eight={2'b11};}

		STOP_BIT:coverpoint cov_data.lcr[2] {bins one={1'b0};
					             bins two={1'b1};}
	
		PARITY_ENB:coverpoint cov_data.lcr[3] {bins on={1'b1};
						       bins off={1'b0};}
		EVEN_PARITY:coverpoint cov_data.lcr[4] {bins even={1'b1};
							bins odd={1'b0};}
			
		STICKY_PARITY:coverpoint cov_data.lcr[5] {bins on={1'b1};
							  bins off={1'b0};}
		BREAK_CONTROL:coverpoint cov_data.lcr[6] {bins on={1'b1};
							  bins off={1'b0};}
		DIVISOR_LATCH:coverpoint cov_data.lcr[7] {bins on={1'b1};
							  bins off={1'b0};}
		//CHAR_SIZE_X_STOP_BIT_X_EV_ODD_PARITY: cross CHAR_SIZE,STOP_BIT,EVEN_PARITY;

	endgroup 

	covergroup uart_ier_cov;
                option.per_instance=1;

                RCVD_INT: coverpoint cov_data.ier[0] { bins dis = {1'b0};
                                                        bins en = {1'b1}; }

                THRE_INT: coverpoint cov_data.ier[1] { bins dis = {1'b0};
                                                        bins en = {1'b1}; }

                LSR_INT: coverpoint cov_data.ier[2] { bins dis = {1'b0};
                                                        bins en = {1'b1}; }

             

        endgroup
	  
	covergroup uart_fcr_cov;
                option.per_instance=1;

                RFIFO: coverpoint cov_data.fcr[1] { bins dis = {1'b0};
                                                    bins clr = {1'b1}; }

                TFIFO: coverpoint cov_data.fcr[2] { bins dis = {1'b0};
                                                    bins clr = {1'b1}; }

                TRG_LVL: coverpoint cov_data.fcr[7:6] { bins one = {2'b00};
                                                        bins four = {2'b01};
                                                        bins eight = {2'b10};
                                                        bins fourteen = {2'b11}; }

               

        endgroup
	
	 covergroup uart_iir_cov;
                option.per_instance=1;

                IIR: coverpoint cov_data.iir[3:1] {bins lsr = {3'b011};
                                                   bins rdf = {3'b010};
                                                   bins ti_o = {3'b110};
                                                   bins threm = {3'b001}; }

       

        endgroup
 
	  covergroup uart_lsr_cov;
                option.per_instance=1;

                DATA_READY: coverpoint cov_data.lsr[0] {bins fifoempty = {1'b0};
                                                        bins datarcvd = {1'b1}; }

                OVER_RUN: coverpoint cov_data.lsr[1] {bins nooverrun = {1'b0};
                                                        bins overrun = {1'b1}; }

                PARITY_ERR: coverpoint cov_data.lsr[2] {bins noparityerr = {1'b0};
                                                        bins parityerr = {1'b1} ;}

                FRAME_ERR: coverpoint cov_data.lsr[3] {bins noframeerr = {1'b0};
                                                        bins frameerr = {1'b1}; }

                BREAK_INT: coverpoint cov_data.lsr[4] {bins nobreakint = {1'b0};
                                                        bins breakint = {1'b1}; }

                THR_EMP: coverpoint cov_data.lsr[5] {bins thrnotemp = {1'b0};
                                                        bins thremo = {1'b1}; }

        endgroup
	
endclass

function uart_scoreboard::new(string name="uart_scoreboard",uvm_component parent);
		super.new(name,parent);

		//uart_signals_cov=new();
		uart_fcr_cov=new();
		uart_iir_cov=new();
		uart_ier_cov=new();
		uart_lsr_cov=new();
		uart_lcr_cov=new();
endfunction

function void  uart_scoreboard::build_phase(uvm_phase phase);
		
		if(!uvm_config_db#(uart_env_config)::get(this,"","uart_env_config",env_cfg))
			`uvm_fatal("ENV_CONFIG","Cannot get the env_cfg from config_db. Have you set() iy?")
		
		if(env_cfg.has_wb_agent)
			begin
				fifo_h=new[env_cfg.no_of_agts];
				foreach(fifo_h[i])
					fifo_h[i]=new($sformatf("fifo_h[%0d]",i),this);
			end
		
		

			super.build_phase(phase);

endfunction

task  uart_scoreboard::run_phase(uvm_phase phase);

fork
	forever 
		begin
			fifo_h[0].get(xtn1);
			cov_data=xtn1;
		//	uart_signals_cov.sample();
			uart_lcr_cov.sample();
                        uart_ier_cov.sample();
                        uart_fcr_cov.sample();
                        uart_iir_cov.sample();
                        uart_lsr_cov.sample();

		end
	forever 
		begin
			fifo_h[1].get(xtn2);
			cov_data=xtn2;
			//uart_signals_cov.sample();
			uart_lcr_cov.sample();
                        uart_ier_cov.sample();
                        uart_fcr_cov.sample();
                        uart_iir_cov.sample();
                        uart_lsr_cov.sample();

		end
join

endtask

function void uart_scoreboard::check_phase(uvm_phase phase);

	

		$display("THE VALUES SENT BY UART1: %p\n",xtn1.thr);
		$display("THE VALUES SENT BY UART2: %p\n",xtn2.thr);
		$display("THE VALUES RECEIVED BY UART1: %p\n",xtn1.rb);
		$display("THE VALUES RECEIVED BY UART2 : %p\n",xtn2.rb);

//FULL DUPLEX CONDITION AND HALF DUPLEX CONDITION

		thr1size=xtn1.thr.size();
		thr2size=xtn2.thr.size();
		rb1size=xtn1.rb.size();
		rb2size=xtn2.rb.size();

		if((thr1size!=0 && thr2size==0) || (thr1size==0 && thr2size!=0))
		begin
			if((xtn1.thr==xtn2.rb) || (xtn2.thr == xtn1.rb))
			begin
					$display("Half Duplex is Successful");
			end
		end
		else
		begin
			if((xtn1.thr==xtn2.rb) && (xtn2.thr==xtn1.rb))
			begin
					$display("Full Duplex is Successful");		
			end
		end
//PARITY ERROR CONDITION
		$display("LCR:%0b",xtn2.lcr);
		$display("IER:%0b",xtn2.ier);
		$display("IIR:%0b",xtn2.iir);
		$display("LSR:%0b",xtn2.lsr);


		if(xtn2.lcr[3]==1 && xtn2.ier[2]==1 && xtn2.iir[3:1]==3 && xtn2.lsr[2]==1) 
					$display("PARITY ERROR");
		else
					$display("NO PARITY ERROR");

				
endfunction
