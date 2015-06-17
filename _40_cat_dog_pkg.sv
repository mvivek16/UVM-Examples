package cat_dog;

import uvm_pkg::*;
//`include "uvm_macros.svh"
//`define uvm_info(msg) uvm_top.uvm_report_info($psprintf("%m"),msg);

class cat extends uvm_test;
	`uvm_component_utils(cat)
	
	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction : new

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		super.run();
		`uvm_info("cat","The cat says 'meow'",UVM_INFO);
		phase.drop_objection(this);
	endtask
endclass : cat

class dog extends uvm_test;
	`uvm_component_utils(dog)
	
	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction : new

	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		super.run();
		`uvm_info("dog","The Dog says 'baow' 'baow'",UVM_INFO);
		phase.drop_objection(this);
	endtask
endclass : dog

endpackage : cat_dog
