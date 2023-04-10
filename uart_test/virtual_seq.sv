class virtual_seq_base  extends uvm_sequence#(uvm_sequence_item);
  `uvm_object_utils(virtual_seq_base)
    
  wb_sequencer seqrh[];
      
    uart_env_config env_cfg;

  function new(string name="virtual_seq_base");
      super.new(name);
  endfunction

endclass

class v_seq1 extends virtual_seq_base;
  
  `uvm_object_utils(v_seq1)
  
  function new(string name="v_seq1");
      super.new(name);

  endfunction
  
  task body();
    seq1 s1;
    seq2 s2;
   
    s1=seq1::type_id::create("s1");
    s2=seq2::type_id::create("s2");

    fork
      s1.start(seqrh[0]);
      s2.start(seqrh[1]);
    join

  endtask

endclass

class v_seq2 extends virtual_seq_base;
  `uvm_object_utils(v_seq2)

  function new(string name="v_seq2");
    super.new(name);
  endfunction

  task body();
    seq3 s3;
    seq4 s4;

    s3=seq3::type_id::create("s3");
    s4=seq4::type_id::create("s4");
    
    fork
      s3.start(seqrh[0]);
      s4.start(seqrh[1]);
    join
  endtask
endclass

class v_seq3 extends virtual_seq_base;
  `uvm_object_utils(v_seq3)
  
  function new(string name="v_seq3");
    super.new(name);
  endfunction

  task body();
    seq5 s5;
    seq6 s6;
    
    s5=seq5::type_id::create("s5");
    s6=seq6::type_id::create("s6");

    fork
      s5.start(seqrh[0]);
      s6.start(seqrh[1]);
    join
  endtask
endclass
