class scoreboard extends uvm_agent;
  `uvm_component_utils(scoreboard)
  
  virtual interface memory_if mif;
  
  logic [15:0] testmem [2**16 -1 :0];
  
  //constructor
  function new(string name = "scoreboard", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    mif = mem_pkg::global_mif;
  endfunction : build_phase
  
  task run_phase(uvm_phase phase);
    forever begin
      @(posedge mif.clk);
      if(mif.rd) begin
	#1;
	assert(mif.data === mif.testmem[mif.addr]) else
	uvm_report_error("run",$psprintf("Expected %0h actual %0h",testmem[mif.addr],mif.data));
      end

      if(mif.wr) begin
	mif.testmem[mif.addr] = mif.data;
      end
      
    end
  endtask : run_phase
  
endclass : scoreboard
