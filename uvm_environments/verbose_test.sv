class verbose_test extends uvm_test;
  `uvm_component_utils(verbose_test)
  
  tester_env t_env;	//instantiation of the environment
  virtual interface memory_if mif;
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase (uvm_phase phase);
    mif = mem_pkg::global_mif;
    t_env = tester_env::type_id::create("t_env",this);
  endfunction : build_phase
  
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
  
  