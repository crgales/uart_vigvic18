interface wb_if(input bit clk);
	/*parameter uart_data_width = 8;
	parameter uart_addr_width = 3; */
	logic wb_rst_i;
	logic [2:0] wb_addr_i;
	logic [7:0] wb_dat_i;
	logic [7:0]wb_dat_o;
	logic [3:0] wb_sel_i;
	logic wb_we_i;
	logic wb_stb_i;
	logic wb_cyc_i;
	logic wb_ack_o;
	logic wb_int_o;
	logic srx_pad_i;
	logic stx_pad_o;
	bit wb_clk;
	
	assign wb_clk=clk;


	clocking wb_driv@(posedge clk);

		default input #1 output #1;
		
		output wb_rst_i;
		output  wb_addr_i;
		output  wb_sel_i;
		output wb_dat_i;
		output wb_we_i;
		output wb_stb_i;
		output wb_cyc_i;
		input wb_ack_o;
	//	output wb_ack_o;	
		input wb_dat_o;
		input wb_int_o;
	
	endclocking

	clocking wb_mon@(posedge clk);
		
		default input #1 output #1;
		
		input wb_rst_i;
		input wb_addr_i;
		input wb_sel_i;
		input wb_dat_i;
		input wb_we_i;
		input wb_stb_i;
		input wb_cyc_i;
		input wb_ack_o;
		input  wb_dat_o;
		input wb_int_o;
	endclocking

	modport WB_DRIV(clocking wb_driv);
	
	modport WB_MON(clocking wb_mon);
	
endinterface

