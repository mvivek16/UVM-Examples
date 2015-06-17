module top();
	
	memory_if mi();
	memory dut(mi.mem_mp);
	tester tst(mi.tester);

endmodule

interface memory_if;
	logic [15:0] wr_data_reg;
	wire [15:0] data;
	logic [15:0] addr;
	bit clk;
	bit rd;
	bit wr;

	modport mem_mp(
			inout data,
			input addr,
			input clk,
			input rd,
			input wr);

	modport tester(
			output wr_data_reg,
			input clk,
			output addr,
			output rd,
			output wr);

	assign data = (wr) ? wr_data_reg : 16'hzzzz;
	
	initial begin
		$monitor("addr: %1h data: %4h rd: %1b wr: %1b", addr, data, rd, wr);
			clk = 0;
			forever begin
			#10;
			clk = ~clk;
		end
	end

	logic [15:0] testmem [2**16 - 1 : 0];
	
	always @(posedge clk) begin
		if(rd) begin
			#1;
			assert(data === testmem[addr]);
		end

		if(wr) begin
			testmem[addr] = data;
		end
	end

endinterface: memory_if

module memory(memory_if.mem_mp m);
	logic [15:0] mem [2**16 - 1: 0];
	assign m.data = (m.rd) ? mem[m.addr]: 16'hZZZZ;
	
	always @(posedge m.clk)
		if(m.wr)
		mem[m.addr] = m.data;
endmodule

module tester(memory_if.tester t);
logic [3:0] tiny_addr;
integer i;
initial begin
	t.wr = 1'b1;
	
	for (i= 0; i <'h10 ; i++) begin
		@(negedge t.clk);
		t.wr_data_reg = i;
		t.addr = i;
	end

	repeat(50) begin
		@(negedge t.clk);
		t.wr = $random;
		t.rd = ~t.wr;
		tiny_addr = $random;
		t.addr = {12'd0,tiny_addr};
		if(t.wr) begin
			t.wr_data_reg = $random;
		end
	end
	$finish;
end

endmodule
		
