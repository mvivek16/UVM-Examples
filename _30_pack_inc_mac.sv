`timescale 1ns/10ps

module top;
	initial $timeformat(-9, 0, " ns");
	mod1 m1();
	mod2 m2();
endmodule

module mod1();
	integer a;
	
	initial begin
		#5ns;
		a = 1;
		$display("%0t: a in %m: %0d", $time,a);
	end
endmodule

module mod2;
	integer a;

	initial begin
		a = 10;
		#6ns;
		$display("%0t: a in %m: %0d", $time,a);
	end
endmodule
