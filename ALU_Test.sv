`ifndef ALU_TEST_SV
`define ALU_TEST_SV

`include "uvm_macros.svh"
`include "ALU_Env.sv"
`include "ALU_Transaction.sv"
`include "ALU_Sequence.sv"

import uvm_pkg::*;

class ALU_Test extends uvm_test;
    `uvm_component_utils(ALU_Test)
    ALU_Env alu_env;
	virtual ALU_interface alu_vi;
	ALU_Sequence alu_seq;

function new (string name = "ALU_Test", uvm_component parent);
   super.new(name,parent);
endfunction

virtual function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    alu_env = ALU_Env::type_id::create("alu_env",this);
	//get virtual interface handle 
	if (!uvm_config_db #(virtual ALU_interface)::get(this,"","ALU_interface",alu_vi)) begin
			`uvm_fatal("Test","Couldn't obtain virtual interface")
	end
	uvm_config_db #(virtual ALU_interface)::set(this,"alu_env.alu_agnt.*","ALU_interface",alu_vi);
	 

endfunction

virtual task run_phase(uvm_phase phase);
    //create a sequence
	alu_seq = ALU_Sequence::type_id::create("alu_seq");
    phase.raise_objection(this);
    alu_seq.start(alu_env.alu_agnt.alu_seqr);
	#10000;
    phase.drop_objection(this);
endtask

endclass




`endif
