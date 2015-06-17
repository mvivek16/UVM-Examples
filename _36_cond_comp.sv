import uvm_pkg::*;

`define INFO(msg)	uvm_top.uvm_report_info($psprintf("%m"),msg);
//`define FIRST 1

`ifdef FIRST
module top;
initial `INFO("FIRST Defined");
endmodule

`else
module top;
initial `INFO("FIRST Undefined");
endmodule

`endif
