`ifndef ALU_SCOREBOARD_SV
`define ALU_SCOREBOARD_SV

`include "uvm_macros.svh"
`include "ALU_Transaction.sv"
import uvm_pkg::*;
import definitions::*;

class ALU_Scoreboard  extends uvm_subscriber #(ALU_Transaction);
  `uvm_component_utils(ALU_Scoreboard)
   ALU_Transaction alu_trans;

   function new (string name = "ALU_Scoreboard", uvm_component parent = null);
       super.new(name,parent);
   endfunction

   virtual function void build_phase (uvm_phase phase);
       super.build_phase(phase);
       //alu_ap_imp = new("alu_ap_imp",this);
       alu_trans = ALU_Transaction::type_id::create("alu_trans");
   endfunction

   // Action to be taken when data is received from the analysis port
   virtual function void write(ALU_Transaction t);
	   logic [OUTPUT_SIZE-1:0] exp_out;
	   ALU_Transaction alu_trans_act = t;
      `uvm_info("write",$sformatf("in1 = 0x%0h, in2 = 0x%0h, opcode = %0s",alu_trans_act.in1,alu_trans_act.in2,alu_trans_act.opcode),UVM_NONE);
	    case (alu_trans_act.opcode)
            ADD    : exp_out = alu_trans_act.in1 + alu_trans_act.in2;
            SUB    : exp_out = alu_trans_act.in1 - alu_trans_act.in2;
            MUL    : exp_out = alu_trans_act.in1 * alu_trans_act.in2;
            DIV    : begin
                        if (alu_trans_act.in2 == 'b0) $error("division by zero !");
                        else exp_out = alu_trans_act.in1 / alu_trans_act.in2;
                     end
            SL     : exp_out = alu_trans_act.in1 << 1;
            SR     : exp_out = alu_trans_act.in1 >> 1;
            AND    : exp_out = alu_trans_act.in1 & alu_trans_act.in2;
            OR     : exp_out = alu_trans_act.in1 | alu_trans_act.in2;
            NOT    : exp_out = ~alu_trans_act.in1;
            XOR    : exp_out = alu_trans_act.in1 ^ alu_trans_act.in2;
            default: exp_out = 'b0;
        endcase
        
        if (exp_out != alu_trans_act.out) begin
            `uvm_error("ALU_Scoreboard",$sformatf("ERROR : Expected output: %d, Output: %d ",exp_out ,alu_trans_act.out));
        end
        else begin
            `uvm_info("ALU_Scoreboard",$sformatf("Test Passed : Expected output: %d, Output: %d ",exp_out ,alu_trans_act.out),UVM_NONE);
        end
   endfunction
 

endclass
`endif
