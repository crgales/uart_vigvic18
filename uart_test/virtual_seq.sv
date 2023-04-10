class virtual_seq_base  extends uvm_sequence#(uvm_sequence_item);
		
		`uvm_object_utils(virtual_seq_base)

		virtual_sequencer cvsqrh;
		
		uart_sequencer seqrh[];
			
		seq1 s1;
		
		seq2 s2;
		
		seq3 s3;

		seq4 s4;

		seq5 s5;
		
		seq6 s6;
		
		uart_env_config env_cfg;

	function new(string name="virtual_seq_base");
			super.new(name);
	endfunction

	task body();
		
		if(!uvm_config_db#(uart_env_config)::get(null,get_full_name,"uart_env_config",env_cfg))
			`uvm_fatal("ENV_CONFIG","Cannot get() env_cfg from Config Database. Have you set() it?")
		seqrh=new[env_cfg.no_of_duts];
	
		assert($cast(cvsqrh,m_sequencer)) else begin
			`uvm_error("BODY","Error in $cast in virtual sequencer")
		end

		foreach(seqrh[i])
			seqrh[i]=cvsqrh.agt_vsqrh[i];

	endtask
endclass

class v_seq1 extends virtual_seq_base;
	
	`uvm_object_utils(v_seq1)
	
	function new(string name="v_seq1");
			super.new(name);

	endfunction
	
	task body();
	
		super.body();
	
		s1=seq1::type_id::create("s1");
		
		s2=seq2::type_id::create("s2");

		fork 
		   begin
			if(env_cfg.has_wb_agent)
					fork
						s1.start(seqrh[0]);
						s2.start(seqrh[1]);
					join
		   end
		join

	endtask

endclass

class v_seq2 extends virtual_seq_base;

        `uvm_object_utils(v_seq2)

        function new(string name="v_seq2");
                        super.new(name);

        endfunction

        task body();

                super.body();

                s3=seq3::type_id::create("s3");

                s4=seq4::type_id::create("s4");

                fork
                   begin
                        if(env_cfg.has_wb_agent)
                                        fork
                                                s3.start(seqrh[0]);
                                                s4.start(seqrh[1]);
                                        join
                   end
                join

        endtask

endclass



class v_seq3 extends virtual_seq_base;

        `uvm_object_utils(v_seq3)

        function new(string name="v_seq3");
                        super.new(name);

        endfunction

        task body();

                super.body();

                s5=seq5::type_id::create("s5");

                s6=seq6::type_id::create("s6");

                fork
                   begin
                        if(env_cfg.has_wb_agent)
                                        fork
                                                s5.start(seqrh[0]);
                                                s6.start(seqrh[1]);
                                        join
                   end
                join

        endtask

endclass

