//`include "top_gint.sv"

class verbose_test extends quiet_test;
	`uvm_component_utils(verbose_test)
	
	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction : new

	virtual task run_phase(uvm_phase phase);
		int nloops = 5;
		logic [3:0] tiny_addr;
	
		phase.raise_objection(this);
		mif.wr = 1'b1;
	
		for (int i= 0; i <'h10 ; i++) begin
			@(negedge mif.clk);
			mif.wr_data_reg = i;
			mif.addr = i;
			`uvm_info("TESTER",$psprintf("addr : %4h data: %2h rd : %1b wr: %1b",mif.addr,mif.data,mif.rd,mif.wr),UVM_INFO);
		end
		uvm_report_info("MEMORY_TEST",$psprintf("Running %0d loops",nloops));

		repeat(nloops) begin
			@(negedge mif.clk);
			mif.wr = $random;
			mif.rd = ~mif.wr;
			tiny_addr = $random;
			mif.addr = {12'd0,tiny_addr};
			if(mif.wr) begin
				mif.wr_data_reg = $random;
			end
		end
		@(negedge mif.clk);
		phase.drop_objection(this);
		//$finish;
	endtask
endclass : verbose_test
