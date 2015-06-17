package mypackage;
  typedef enum {read,write} op_t;
  typedef logic [7:0] data_t;
  typedef logic [15:0] addr_t;

class mem_op;
  rand op_t op;
  rand data_t data;
  rand addr_t addr;

  function new(addr_t a = 0, data_t d = 0, op_t o = read);
		addr = a;
		data = d;
		op = o;
	endfunction
  
  function string convert2string();
    string 		s;
    $sformat(s,"addr: %4h data: %2h op: %0s", addr, data, op);
    return s;
  endfunction
endclass : mem_op

  mem_op common_op = new();
  
endpackage
