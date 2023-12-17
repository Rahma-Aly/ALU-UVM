`ifndef COVERAGE_SV
`define COVERAGE_SV
`include "uvm_macros.svh"
`include "ALU_Transaction.sv"
import uvm_pkg::*;
import definitions::*;

class Coverage extends uvm_subscriber #(ALU_Transaction);
    `uvm_component_utils(Coverage);
	ALU_Transaction alu_trans;
    
    covergroup opcode_cov;
        OP: coverpoint alu_trans.opcode {
            bins op[]     = {NOP,ADD,SUB,MUL,DIV,SL,SR,AND,OR,NOT,XOR};
            bins np_op[]  = (NOP => [ADD:XOR]);
            bins op_np [] = ([ADD:XOR] => NOP);
        }
        
    endgroup
    
    covergroup in_val;
        IN1: coverpoint alu_trans.in1 {
            bins zeros    = {'b0};
            bins ones     = {'hFF};
            bins others[] = {['h1:'hFE]}; 
        }
        IN2: coverpoint alu_trans.in2 {
            bins zeros    = {'b0};
            bins ones     = {'hFF};
            bins others[] = {['h1:'hFE]}; 
        }
        IN1_IN2: cross alu_trans.in1, alu_trans.in2;    
    endgroup
	
    
    function new (string name = "coverage", uvm_component parent);
		super.new(name,parent);
		opcode_cov = new();
        in_val = new();
    endfunction: new 
    
    function void build_phase (uvm_phase phase);
         super.build_phase(phase);
		 alu_trans = ALU_Transaction::type_id::create("alu_trans");
    endfunction : build_phase
	
	virtual function void write (ALU_Transaction t);
	    alu_trans = t;
		opcode_cov.sample();
        in_val.sample();
	endfunction
	

endclass


`endif

