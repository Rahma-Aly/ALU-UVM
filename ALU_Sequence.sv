`ifndef ALU_SEQUENCE_SV
`define ALU_SEQUENCE_SV

`include "uvm_macros.svh"
`include "ALU_Transaction.sv"
import uvm_pkg::*;
import definitions::*;

class ALU_Sequence extends uvm_sequence #(ALU_Transaction);
   `uvm_object_utils(ALU_Sequence)
    ALU_Transaction    alu_trans;
    int unsigned       n     = 3000;

    function new (string name = "alu_seq"); 
      super.new(name);
    endfunction
    
    task body();
     alu_trans = ALU_Transaction::type_id::create("alu_trans");
      repeat(n) begin
         start_item(alu_trans);
         assert(alu_trans.randomize());
		 #10;
         finish_item(alu_trans);
      end
    endtask

endclass

`endif
