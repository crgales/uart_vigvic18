`timescale 1ns/1ps
module top;
	import uart_test_pkg::*;
	import uvm_pkg::*;
	bit clk1,clk2;
	
	always #5 clk1=!clk1;
	always #10  clk2=!clk2;
		
	wb_if in0(clk1);
	wb_if in1(clk2);
	
	wire w1,w2;
	
	uart_top DUV1(.wb_clk_i(clk1),.wb_rst_i(in0.wb_rst_i),.wb_adr_i(in0.wb_addr_i),.wb_sel_i(in0.wb_sel_i),.wb_dat_i(in0.wb_dat_i),.wb_we_i(in0.wb_we_i),.wb_stb_i(in0.wb_stb_i),.wb_cyc_i(in0.wb_cyc_i),.wb_ack_o(in0.wb_ack_o),.wb_dat_o(in0.wb_dat_o),.int_o(in0.wb_int_o),.stx_pad_o(w1),.srx_pad_i(w2));

	uart_top DUV2(.wb_clk_i(clk2),.wb_rst_i(in1.wb_rst_i),.wb_adr_i(in1.wb_addr_i),.wb_sel_i(in1.wb_sel_i),.wb_dat_i(in1.wb_dat_i),.wb_we_i(in1.wb_we_i),.wb_stb_i(in1.wb_stb_i),.wb_cyc_i(in1.wb_cyc_i),.wb_ack_o(in1.wb_ack_o),.wb_dat_o(in1.wb_dat_o),.int_o(in1.wb_int_o),.srx_pad_i(w1),.stx_pad_o(w2));

	initial begin

		uvm_config_db #(virtual wb_if)::set(null,"*","vif_0",in0);
		uvm_config_db #(virtual wb_if)::set(null,"*","vif_1",in1);
		
		run_test();
	
	end

endmodule

