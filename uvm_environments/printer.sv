class printer extends uvm_agent;
  `uvm_component_utils(printer)
  
  virtual interface memory_if mif;
  
  //constructor
  function new(string name = "printer", uvm_component parent = null);
    super.new(name,parent);
  endfunction : new
  
  //build
  virtual function void build_phase(uvm_phase phase);
    mif = mem_pkg::global_mif;
  endfunction : build_phase
  
  task run_phase(uvm_phase phase);
    forever begin
      @(posedge mif.clk);
      uvm_report_info("run",$psprintf("addr: %1h data: %4h rd: %1h wr: %1h",mif.addr,mif.data,mif.rd,mif.wr));
    end
  endtask : run_phase
  
endclass : printer