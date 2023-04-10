class reg_config extends uvm_object;
		
	`uvm_object_utils(reg_config)
	

	rand bit [1:0] lcr;
	

	rand bit [7:6] fcr;

	//rand bit [1:0] parity;

	
	function new(string name="reg_config");
			super.new(name);
	endfunction
endclass

