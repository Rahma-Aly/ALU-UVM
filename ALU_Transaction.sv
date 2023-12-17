`ifndef ALU_TRANSACTION_SV
`define ALU_TRANSACTION_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
import definitions::*;

class ALU_Transaction extends uvm_sequence_item;
 `uvm_object_utils(ALU_Transaction)

    rand bit [DATASIZE-1:0] in1;
    rand bit [DATASIZE-1:0] in2;
    rand opcodes_t          opcode;
    bit [OUTPUT_SIZE-1:0]    out;
    
    constraint  rand_opcode {opcode inside {NOP,ADD,SUB,MUL,DIV,SL,SR,AND,OR,NOT,XOR};}
 
    function new (string name = "Transaction");
        super.new(name);
    endfunction

   virtual function string convert2str();
      return $sformatf("Input 1 = 0x%0h, Input 2 = 0x%0h, opcode = %s, Output = 0x%0h",in1,in2,opcode.name(),out);
   endfunction
 
endclass


`endif

