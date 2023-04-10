`timescale 1ns/10ps
module top;
  import uart_test_pkg::*;
  import uvm_pkg::*;

  bit clk, rst;
	
  initial begin
	clk = 0;
	forever #5 clk=~clk;
  end

  initial begin
    rst = 1;
	repeat (10) @(posedge clk);
	rst = 0;
  end
		
  wb_if in0(clk,rst);
  wb_if in1(clk,rst);
	
  wire w1,w2;
	
  uart_top DUV1(
	.wb_clk_i(clk),
	.wb_rst_i(rst),
	.wb_adr_i(in0.wb_addr_i),
	.wb_sel_i(in0.wb_sel_i),
	.wb_dat_i(in0.wb_dat_i),
	.wb_we_i(in0.wb_we_i),
	.wb_stb_i(in0.wb_stb_i),
	.wb_cyc_i(in0.wb_cyc_i),
	.wb_ack_o(in0.wb_ack_o),
	.wb_dat_o(in0.wb_dat_o),
	.int_o(in0.wb_int_o),
	.stx_pad_o(w1),
	.srx_pad_i(w2),
	.baud_o(),
	.dcd_pad_i(),
	.ri_pad_i(),
	.dsr_pad_i(),
	.dtr_pad_o(),
	.cts_pad_i(),
	.rts_pad_o()
  );

  uart_top DUV2(.wb_clk_i(clk),
    .wb_rst_i(rst),
	.wb_adr_i(in1.wb_addr_i),
	.wb_sel_i(in1.wb_sel_i),
	.wb_dat_i(in1.wb_dat_i),
	.wb_we_i(in1.wb_we_i),
	.wb_stb_i(in1.wb_stb_i),
	.wb_cyc_i(in1.wb_cyc_i),
	.wb_ack_o(in1.wb_ack_o),
	.wb_dat_o(in1.wb_dat_o),
	.int_o(in1.wb_int_o),
	.stx_pad_o(w2),
	.srx_pad_i(w1),
	.baud_o(),
	.dcd_pad_i(),
	.ri_pad_i(),
	.dsr_pad_i(),
	.dtr_pad_o(),
	.cts_pad_i(),
	.rts_pad_o()
  );

  initial begin
    uvm_config_db #(virtual wb_if)::set(null,"uvm_test_top","vif_0",in0);
    uvm_config_db #(virtual wb_if)::set(null,"uvm_test_top","vif_1",in1);

    run_test();
end

endmodule

