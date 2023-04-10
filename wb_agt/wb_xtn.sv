class uart_xtn extends uvm_sequence_item;
	

	`uvm_object_utils(uart_xtn)
	
	rand logic [2:0] wb_addr_i;
	rand logic [7:0] wb_dat_i;
	rand logic wb_we_i;
	
	rand bit [4:0]data;

	bit  wb_stb_i;
	bit  wb_cyc_i;
	bit  wb_ack_o;
	
	bit  [3:0]wb_sel_i;
	bit  [7:0]wb_dat_o;
	
	//REGISTERS LIST

	bit [7:0] thr[$];
	bit [7:0] rb[$];
	bit [7:0] ier;
	bit [7:0] iir;
        bit [7:0] fcr;
	bit [7:0] lcr;
	bit [7:0] lsr;
	bit [7:0] dlr_1;
	bit [7:0] dlr_2;
	bit [7:0] mcr;

	//CONSTRAINT

	constraint C1{mcr[4]==0;}



	extern function new(string name="uart_xtn");
	extern function void do_print(uvm_printer printer);

endclass

function uart_xtn::new(string name="uart_xtn");
	super.new(name);
endfunction

function void uart_xtn::do_print(uvm_printer printer);
	
	super.do_print(printer);

	printer.print_field("Wishbone Addr", this.wb_addr_i,3,UVM_DEC);
	
	printer.print_field("Wishbone Data",this.wb_dat_i,8,UVM_BIN);

	printer.print_field("Wishbone Write",this.wb_we_i,1,UVM_DEC);
	
	printer.print_field("Wishbone Data_out",this.wb_dat_o,8,UVM_DEC);
	
	//REGISTER PRINTING//
	
	foreach(thr[i])
		printer.print_field($sformatf("THR[%0d]",i),this.thr[i],8,UVM_BIN);
	foreach(rb[i])
		printer.print_field($sformatf("RB[%0d]",i),this.rb[i],8,UVM_BIN);
	printer.print_field("IER",this.ier,8,UVM_BIN);
	printer.print_field("IIR",this.iir,8,UVM_BIN);
	printer.print_field("FCR",this.fcr,8,UVM_BIN);
	printer.print_field("LCR",this.lcr,8,UVM_BIN);
	printer.print_field("LSR",this.lsr,8,UVM_BIN);
	printer.print_field("DLR_1",this.dlr_1,8,UVM_BIN);
	printer.print_field("DLR_2",this.dlr_2,8,UVM_BIN);


endfunction


