class base_seq extends uvm_sequence#(  wb_xtn);

  `uvm_object_utils(base_seq)

  reg_config r_cfg;

  function new(string name="base_seq");
    super.new(name);
  endfunction

endclass
//---------------------------------------------------------FULL DUPLEX----------------------------------------//
class seq1 extends base_seq;
  
  `uvm_object_utils(seq1)
  
  

  function new(string name="seq1");
      super.new(name);
  endfunction

  virtual task body();
    begin
      
      req= wb_xtn::type_id::create("req");

      if(!uvm_config_db#(reg_config)::get(get_sequencer(), "","reg_config",r_cfg))
        `uvm_fatal("R_CFG","Failed to get()")
      
    
      //------------------------------------------LCR-->DLR REG ACCESS---------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b1000_0000;  wb_we==1'b1;  wb_addr==3;})
      finish_item(req);
      //-------------------------------------------DLR_MSB--------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_0000;  wb_we==1'b1;  wb_addr==1;})
      finish_item(req);
      //-------------------------------------------DLR_LSB-------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0011_0110;  wb_we==1'b1;  wb_addr==0;})
      finish_item(req);
    
      //-------------------------------------------LCR-->NORMAL REG ACCESS---------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat[7:2]==0;  wb_dat[1:0]==r_cfg.lcr;  wb_we==1'b1;  wb_addr==3;})
      finish_item(req);

      /*start_item(req);
                        assert(req.randomize()with{  wb_dat==8'b0000_0011;  wb_we==1'b1;  wb_addr==3;})
                        finish_item(req);*/




      //--------------------------------------------IER----------------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_0101;  wb_we==1'b1;  wb_addr==1;})
      finish_item(req);
      //--------------------------------------------FCR---------------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_0110;  wb_we==1'b1;  wb_addr==2;})
      finish_item(req);
      //--------------------------------------------THR---------------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_0111;  wb_we==1'b1;  wb_addr==0;})
      finish_item(req);
    
      
    


      //--------------------------------------------IIR---------------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_addr==2;  wb_we==0;})
      finish_item(req);

/*        
      if(req.wb_dat_o==8'b1100_0110)
        begin
          start_item(req);
          assert(req.randomize()with{  wb_we==0;  wb_addr==5;})
          finish_item(req);
        end
      if(req.wb_dat_o==8'b1100_0100)
        begin
      
          start_item(req);  
          assert(req.randomize()with{  wb_we==0;  wb_addr==0;})
          finish_item(req);
        end
      if(req.wb_dat_o==8'b1100_1100)
        begin
          start_item(req);
          assert(req.randomize()with{  wb_we==0;  wb_addr==0;})
          finish_item(req);
        end
      if(req.wb_dat_o==8'b1100_0010)
        begin
          start_item(req);
          assert(req.randomize()with{  wb_we==1;  wb_addr==0;  wb_dat==8'b0000_0101;})
          finish_item(req);
        end
*/
    end
  endtask
endclass
//------------------------------------------------FULL DUPLEX-----------------------------//
class seq2 extends base_seq;
  
  `uvm_object_utils(seq2)
  


  function new(string name="seq2");
      super.new(name);
  endfunction

  virtual task body();
    begin
      
      req=  wb_xtn::type_id::create("req");
      
      if(!uvm_config_db#(reg_config)::get(get_sequencer(), "","reg_config",r_cfg))
                                  `uvm_fatal("R_CFG","Failed to get()")
 


      //------------------------------------------LCR-->DLR REG ACCESS---------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b1000_0000;  wb_we==1'b1;  wb_addr==3;})
      finish_item(req);
      //-------------------------------------------DLR_MSB--------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_0000;  wb_we==1'b1;  wb_addr==1;})
      finish_item(req);
      //-------------------------------------------DLR_LSB-------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0001_1011;  wb_we==1'b1;  wb_addr==0;})
      finish_item(req);
    
      
      //-------------------------------------------LCR-->NORMAL REG ACCESS---------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat[7:2]==0;  wb_dat[1:0]==r_cfg.lcr;  wb_we==1'b1;  wb_addr==3;})
      finish_item(req);

      /*start_item(req);
                        assert(req.randomize()with{  wb_dat==8'b0000_0011;  wb_we==1'b1;  wb_addr==3;})
                        finish_item(req);*/


      //--------------------------------------------IER----------------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_0101;  wb_we==1'b1;  wb_addr==1;})
      finish_item(req);
      //--------------------------------------------FCR---------------------------------//
      /*start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_0110;  wb_we==1'b1;  wb_addr==2;})
      finish_item(req);*/
      start_item(req);
                        assert(req.randomize()with{  wb_dat[7:6]==r_cfg.fcr;  wb_dat[5:3]==0;  wb_dat[2:0]==3'b110;  wb_we==1'b1;  wb_addr==2;})
                        finish_item(req);




      //--------------------------------------------THR---------------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_0111;  wb_we==1'b1;  wb_addr==0;})
      finish_item(req);
    
      



      //--------------------------------------------IIR---------------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_addr==2;  wb_we==0;})
      finish_item(req);

/*
      if(req.wb_dat_o==8'b1100_0110)
        begin
        
          start_item(req);
          assert(req.randomize()with{  wb_we==0;  wb_addr==5;})
          finish_item(req);
        end
      if(req.wb_dat_o==8'b1100_0100)
        begin
      
          start_item(req);  
          assert(req.randomize()with{  wb_we==0;  wb_addr==0;})
          finish_item(req);
        end
      if(req.wb_dat_o==8'b1100_1100)
        begin
          start_item(req);
          assert(req.randomize()with{  wb_we==0;  wb_addr==0;})
          finish_item(req);
        end
      if(req.wb_dat_o==8'b1100_0010)
        begin
          start_item(req);
          assert(req.randomize()with{  wb_we==1;  wb_addr==0;  wb_dat==8'b0000_0101;})
          finish_item(req);
        end
*/
    end
  endtask
endclass



//---------------------------------------------------------HALF DUPLEX----------------------------------------//
class seq3 extends base_seq;
  
  `uvm_object_utils(seq3)
  
  

  function new(string name="seq3");
      super.new(name);
  endfunction

  virtual task body();
    begin
      
      req=  wb_xtn::type_id::create("req");

      if(!uvm_config_db#(reg_config)::get(get_sequencer(), "","reg_config",r_cfg))
        `uvm_fatal("R_CFG","Failed to get()")
      
    
      //------------------------------------------LCR-->DLR REG ACCESS---------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b1000_0000;  wb_we==1'b1;  wb_addr==3;})
      finish_item(req);
      //-------------------------------------------DLR_MSB--------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_0000;  wb_we==1'b1;  wb_addr==1;})
      finish_item(req);
      //-------------------------------------------DLR_LSB-------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0011_0110;  wb_we==1'b1;  wb_addr==0;})
      finish_item(req);
    
      //-------------------------------------------LCR-->NORMAL REG ACCESS---------------//
      
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_0001;  wb_we==1'b1;  wb_addr==3;})
      finish_item(req);




      //--------------------------------------------IER----------------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_0101;  wb_we==1'b1;  wb_addr==1;})
      finish_item(req);
      //--------------------------------------------FCR---------------------------------//
      /*start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_0110;  wb_we==1'b1;  wb_addr==2;})
      finish_item(req);*/
      start_item(req);
                        assert(req.randomize()with{  wb_dat[7:6]==r_cfg.fcr;  wb_dat[5:3]==0;  wb_dat[2:0]==3'b110;  wb_we==1'b1;  wb_addr==2;})
                        finish_item(req);

  

      //--------------------------------------------THR---------------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_0111;  wb_we==1'b1;  wb_addr==0;})
      finish_item(req);
  
    end
      
    

  endtask
endclass
//------------------------------------------------HALF  DUPLEX-----------------------------//
class seq4 extends base_seq;
  
  `uvm_object_utils(seq4)
  


  function new(string name="seq4");
      super.new(name);
  endfunction

  virtual task body();
    begin
      
      req=  wb_xtn::type_id::create("req");
      
    /*  if(!uvm_config_db#(reg_config)::get(get_sequencer(), "","reg_config",r_cfg))
                                  `uvm_fatal("R_CFG","Failed to get()")*/
 


      //------------------------------------------LCR-->DLR REG ACCESS---------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b1000_0000;  wb_we==1'b1;  wb_addr==3;})
      finish_item(req);
      //-------------------------------------------DLR_MSB--------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_0000;  wb_we==1'b1;  wb_addr==1;})
      finish_item(req);
      //-------------------------------------------DLR_LSB-------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0001_1011;  wb_we==1'b1;  wb_addr==0;})
      finish_item(req);
    
      
      //-------------------------------------------LCR-->NORMAL REG ACCESS---------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_0001;  wb_we==1'b1;  wb_addr==3;})
      finish_item(req);
      //--------------------------------------------IER----------------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_0101;  wb_we==1'b1;  wb_addr==1;})
      finish_item(req);
      //--------------------------------------------FCR---------------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_0110;  wb_we==1'b1;  wb_addr==2;})
      finish_item(req);
    /*  //--------------------------------------------THR---------------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_0111;  wb_we==1'b1;  wb_addr==0;})
      finish_item(req);*/
    
      



      //--------------------------------------------IIR---------------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_addr==2;  wb_we==0;})
      finish_item(req);

/*
      if(req.wb_dat_o==8'b1100_0110)
        begin
        
          start_item(req);
          assert(req.randomize()with{  wb_we==0;  wb_addr==5;})
          finish_item(req);
        end
      if(req.wb_dat_o==8'b1100_0100)
        begin
      
          start_item(req);  
          assert(req.randomize()with{  wb_we==0;  wb_addr==0;})
          finish_item(req);
        end
      if(req.wb_dat_o==8'b1100_1100)
        begin
          start_item(req);
          assert(req.randomize()with{  wb_we==0;  wb_addr==0;})
          finish_item(req);
        end
      if(req.wb_dat_o==8'b1100_0010)
        begin
          start_item(req);
          assert(req.randomize()with{  wb_we==1;  wb_addr==0;  wb_dat==8'b0000_0101;})
          finish_item(req);
        end
*/
    end
  endtask
endclass

//---------------------------------------------------------PARITY ERROR---------------------------------------//
class seq5 extends base_seq;
  
  `uvm_object_utils(seq5)

  function new(string name="seq5");
      super.new(name);
  endfunction

  virtual task body();
    begin
      
      req=  wb_xtn::type_id::create("req");

      /*if(!uvm_config_db#(reg_config)::get(get_sequencer(), "","reg_config",r_cfg))
        `uvm_fatal("R_CFG","Failed to get()")*/
      
    
      //------------------------------------------LCR-->DLR REG ACCESS---------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b1000_0000;  wb_we==1'b1;  wb_addr==3;})
      finish_item(req);
      //-------------------------------------------DLR_MSB--------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_0000;  wb_we==1'b1;  wb_addr==1;})
      finish_item(req);
      //-------------------------------------------DLR_LSB-------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0011_0110;  wb_we==1'b1;  wb_addr==0;})
      finish_item(req);
    
      //-------------------------------------------LCR-->NORMAL REG ACCESS---------------//
      
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0001_1011;  wb_we==1'b1;  wb_addr==3;})
      finish_item(req);
       //--------------------------------------------FCR---------------------------------//
                        /*start_item(req);
                        assert(req.randomize()with{  wb_dat==8'b0000_0110;  wb_we==1'b1;  wb_addr==2;})
                        finish_item(req);*/
                        start_item(req);
                        assert(req.randomize()with{  wb_dat==8'b0000_0110;  wb_we==1'b1;  wb_addr==2;})
                        finish_item(req);




      //--------------------------------------------IER----------------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_0100;  wb_we==1'b1;  wb_addr==1;})
      finish_item(req);
    

  

      //--------------------------------------------THR---------------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_0111;  wb_we==1'b1;  wb_addr==0;})
      finish_item(req);
      
      //--------------------------------------------IIR---------------------------------//
                        start_item(req);
                        assert(req.randomize()with{  wb_addr==2;  wb_we==0;})
                        finish_item(req);





/*

                        if(req.wb_dat_o==8'b1100_0110)
                                begin

                                        start_item(req);
                                        assert(req.randomize()with{  wb_we==0;  wb_addr==5;})
                                        finish_item(req);
                                end
                        if(req.wb_dat_o==8'b1100_0100)
                                begin

                                        start_item(req);
                                        assert(req.randomize()with{  wb_we==0;  wb_addr==0;})
                                        finish_item(req);
                                end
                        if(req.wb_dat_o==8'b1100_1100)
                                begin

                                        start_item(req);
                                        assert(req.randomize()with{  wb_we==0;  wb_addr==0;})
                                        finish_item(req);
                                end
                        if(req.wb_dat_o==8'b1100_0010)
                                begin

                                        start_item(req);
                                        assert(req.randomize()with{  wb_we==1;  wb_addr==0;  wb_dat==8'b0000_0101;})
                                        finish_item(req);
                                end
*/
   
  
    end
      
    

  endtask
endclass
//-----------------------------------------------PARITY ERROR-----------------------------//
class seq6 extends base_seq;
  
  `uvm_object_utils(seq6)
  


  function new(string name="seq6");
      super.new(name);
  endfunction

  virtual task body();
    begin
      
      req=  wb_xtn::type_id::create("req");
      
      /*if(!uvm_config_db#(reg_config)::get(get_sequencer(), "","reg_config",r_cfg))
                                  `uvm_fatal("R_CFG","Failed to get()")*/
 


      //------------------------------------------LCR-->DLR REG ACCESS---------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b1000_0000;  wb_we==1'b1;  wb_addr==3;})
      finish_item(req);
      //-------------------------------------------DLR_MSB--------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_0000;  wb_we==1'b1;  wb_addr==1;})
      finish_item(req);
      //-------------------------------------------DLR_LSB-------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0001_1011;  wb_we==1'b1;  wb_addr==0;})
      finish_item(req);
    
      
      //-------------------------------------------LCR-->NORMAL REG ACCESS---------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_1011;  wb_we==1'b1;  wb_addr==3;})
      finish_item(req);

      //--------------------------------------------FCR---------------------------------//
                        start_item(req);
                        assert(req.randomize()with{  wb_dat==8'b0000_0110;  wb_we==1'b1;  wb_addr==2;})
                        finish_item(req);
      //--------------------------------------------IER----------------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_0100;  wb_we==1'b1;  wb_addr==1;})
      finish_item(req);
      //--------------------------------------------THR---------------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_1111;  wb_we==1'b1;  wb_addr==0;})
      finish_item(req);
    
      



      //--------------------------------------------IIR---------------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_addr==2;  wb_we==0;})
      finish_item(req);

/*
      if(req.wb_dat_o==8'b1100_0110)
        begin
          
          start_item(req);
          assert(req.randomize()with{  wb_we==0;  wb_addr==5;})
          finish_item(req);
        end
      if(req.wb_dat_o==8'b1100_0100)
        begin
        
          start_item(req);  
          assert(req.randomize()with{  wb_we==0;  wb_addr==0;})
          finish_item(req);
        end
      if(req.wb_dat_o==8'b1100_1100)
        begin
          
          start_item(req);
          assert(req.randomize()with{  wb_we==0;  wb_addr==0;})
          finish_item(req);
        end
      if(req.wb_dat_o==8'b1100_0010)
        begin
          
          start_item(req);
          assert(req.randomize()with{  wb_we==1;  wb_addr==0;  wb_dat==8'b0000_0101;})
          finish_item(req);
        end
*/
    end
  endtask
endclass




//---------------------------------------------------------FRAMING  ERROR---------------------------------------//
class seq7 extends base_seq;
  
  `uvm_object_utils(seq7)
  
  

  function new(string name="seq7");
      super.new(name);
  endfunction

  virtual task body();
    begin
      
      req=  wb_xtn::type_id::create("req");

      /*if(!uvm_config_db#(reg_config)::get(get_sequencer(), "","reg_config",r_cfg))
        `uvm_fatal("R_CFG","Failed to get()")*/
      
    
      //------------------------------------------LCR-->DLR REG ACCESS---------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b1000_0000;  wb_we==1'b1;  wb_addr==3;})
      finish_item(req);
      //-------------------------------------------DLR_MSB--------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_0000;  wb_we==1'b1;  wb_addr==1;})
      finish_item(req);
      //-------------------------------------------DLR_LSB-------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0011_0110;  wb_we==1'b1;  wb_addr==0;})
      finish_item(req);
    
      //-------------------------------------------LCR-->NORMAL REG ACCESS---------------//
      
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0001_1011;  wb_we==1'b1;  wb_addr==3;})
      finish_item(req);
       //--------------------------------------------FCR---------------------------------//
                        /*start_item(req);
                        assert(req.randomize()with{  wb_dat==8'b0000_0110;  wb_we==1'b1;  wb_addr==2;})
                        finish_item(req);*/
                        start_item(req);
                        assert(req.randomize()with{  wb_dat==8'b0000_0110;  wb_we==1'b1;  wb_addr==2;})
                        finish_item(req);




      //--------------------------------------------IER----------------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_0100;  wb_we==1'b1;  wb_addr==1;})
      finish_item(req);
    

  

      //--------------------------------------------THR---------------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_0111;  wb_we==1'b1;  wb_addr==0;})
      finish_item(req);
      
      //--------------------------------------------IIR---------------------------------//
                        start_item(req);
                        assert(req.randomize()with{  wb_addr==2;  wb_we==0;})
                        finish_item(req);
/*
                        if(req.wb_dat_o==8'b1100_0110)
                                begin

                                        start_item(req);
                                        assert(req.randomize()with{  wb_we==0;  wb_addr==5;})
                                        finish_item(req);
                                end
                        if(req.wb_dat_o==8'b1100_0100)
                                begin

                                        start_item(req);
                                        assert(req.randomize()with{  wb_we==0;  wb_addr==0;})
                                        finish_item(req);
                                end
                        if(req.wb_dat_o==8'b1100_1100)
                                begin

                                        start_item(req);
                                        assert(req.randomize()with{  wb_we==0;  wb_addr==0;})
                                        finish_item(req);
                                end
                        if(req.wb_dat_o==8'b1100_0010)
                                begin

                                        start_item(req);
                                        assert(req.randomize()with{  wb_we==1;  wb_addr==0;  wb_dat==8'b0000_0101;})
                                        finish_item(req);
                                end
*/
    end
      
    

  endtask
endclass
//-----------------------------------------------FRAMING  ERROR-----------------------------//
class seq8 extends base_seq;
  
  `uvm_object_utils(seq8)
  


  function new(string name="seq8");
      super.new(name);
  endfunction

  virtual task body();
    begin
      
      req=  wb_xtn::type_id::create("req");
      
      /*if(!uvm_config_db#(reg_config)::get(get_sequencer(), "","reg_config",r_cfg))
                                  `uvm_fatal("R_CFG","Failed to get()")*/
 


      //------------------------------------------LCR-->DLR REG ACCESS---------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b1000_0000;  wb_we==1'b1;  wb_addr==3;})
      finish_item(req);
      //-------------------------------------------DLR_MSB--------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_0000;  wb_we==1'b1;  wb_addr==1;})
      finish_item(req);
      //-------------------------------------------DLR_LSB-------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0001_1011;  wb_we==1'b1;  wb_addr==0;})
      finish_item(req);
    
      
      //-------------------------------------------LCR-->NORMAL REG ACCESS---------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_1011;  wb_we==1'b1;  wb_addr==3;})
      finish_item(req);

      //--------------------------------------------FCR---------------------------------//
                        start_item(req);
                        assert(req.randomize()with{  wb_dat==8'b0000_0110;  wb_we==1'b1;  wb_addr==2;})
                        finish_item(req);
      //--------------------------------------------IER----------------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_0100;  wb_we==1'b1;  wb_addr==1;})
      finish_item(req);
      //--------------------------------------------THR---------------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_dat==8'b0000_1111;  wb_we==1'b1;  wb_addr==0;})
      finish_item(req);
    
      



      //--------------------------------------------IIR---------------------------------//
      start_item(req);
      assert(req.randomize()with{  wb_addr==2;  wb_we==0;})
      finish_item(req);
        
/*
      if(req.wb_dat_o==8'b1100_0110)
        begin
          
          start_item(req);
          assert(req.randomize()with{  wb_we==0;  wb_addr==5;})
          finish_item(req);
        end
      if(req.wb_dat_o==8'b1100_0100)
        begin
        
          start_item(req);  
          assert(req.randomize()with{  wb_we==0;  wb_addr==0;})
          finish_item(req);
        end
      if(req.wb_dat_o==8'b1100_1100)
        begin
          
          start_item(req);
          assert(req.randomize()with{  wb_we==0;  wb_addr==0;})
          finish_item(req);
        end
      if(req.wb_dat_o==8'b1100_0010)
        begin
          
          start_item(req);
          assert(req.randomize()with{  wb_we==1;  wb_addr==0;  wb_dat==8'b0000_0101;})
          finish_item(req);
        end
*/
    end
  endtask
endclass

