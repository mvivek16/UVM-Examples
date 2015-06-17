import uvm_pkg::*;
//`include "top_gint.sv"
`include "uvm_macros.svh"
package mem_pkg;
	
	//`include "uvm_macros.svh"
//`include "quiet_test.svh"
//`include "verbose_test.svh"

	virtual interface memory_if global_mif;

endpackage : mem_pkg
