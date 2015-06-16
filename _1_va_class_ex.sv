module va_class_ex();
typedef logic[15:0] addr_t;
typedef logic[7:0] data_t;
typedef enum {read , write} mem_op_t;

class memory_op;
	rand addr_t addr;
	rand data_t data;
	rand mem_op_t mem_op;

	function new(addr_t a = 0, data_t d = 0, mem_op_t o = read);
		addr = a;
		data = d;
		mem_op = o;
	endfunction

	function string convert2string();
		string s;
		$sformat(s,"addr %0h data %0h op %s", addr, data, mem_op);
		return s;
	endfunction
endclass

initial begin
	memory_op op;
	op = new();
	repeat(5) begin
		assert(op.randomize());
		$display("op --> %s",op.convert2string);
	end
end

endmodule
 
