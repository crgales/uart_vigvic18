class wb_xtn extends uvm_sequence_item;
  
  `uvm_object_utils(wb_xtn)
  
  rand logic [2:0] wb_addr;
  rand logic [7:0] wb_dat;
  rand logic wb_we;

  function new(string name="wb_xtn");
    super.new(name);
  endfunction

  function string convert2string();
    string s;

    s = super.convert2string();

    $sformat(s, "%sWishbone Addr: %0h\n",s, wb_addr);
    $sformat(s, "%sWishbone Data: %0h\n",s, wb_dat);
    $sformat(s, "%sWishbone Write: %0h\n",s, wb_we);

    return s;
  endfunction

  function void do_print(uvm_printer printer);
    printer.m_string = convert2string();
  endfunction

endclass



