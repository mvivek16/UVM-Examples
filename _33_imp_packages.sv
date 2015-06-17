`timescale 1ns/10ps

`include "package.sv"

import mypackage::*;

module mod1();
	initial begin
		#5ns;
		a = 1;
		$display("%0t: a in %m: %0d", $time,a);
	end
endmodule

module mod2;
	//integer a;
	initial begin
		a = 10;
		#6ns;
		$display("%0t: a in %m: %0d", $time,a);
	end
endmodule
