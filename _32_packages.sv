`timescale 1ns/10ps

package mypackage;		
	integer a;
endpackage

module mod1();
	initial begin
		#5ns;
		mypackage::a = 1;
		$display("%0t: a in %m: %0d", $time,mypackage::a);
	end
endmodule

module mod2;
	integer a;		//local namespace
	initial begin
		mypackage::a = 10;
		#6ns;
		$display("%0t: a in %m: %0d", $time,mypackage::a);
	end
endmodule
