`ifndef  ALU_AGENT_SV
`define  ALU_AGENT_SV


`include "uvm_macros.svh"
`include "ALU_Transaction.sv"
`include "monitor.sv"
`include "ALU_Driver.sv"

import uvm_pkg::*;


class ALU_Agent extends uvm_agent;
  `uvm_component_utils(ALU_Agent)
   monitor                              alu_monitor;
   ALU_Driver                           alu_driver;
   uvm_sequencer #(ALU_Transaction)     alu_seqr;  

   function new (string name = "ALU_Agent", uvm_component parent = null);
      super.new(name,parent);
   endfunction

   virtual function void build_phase (uvm_phase phase);
       super.build_phase(phase);
	   alu_seqr = uvm_sequencer#(ALU_Transaction) :: type_id :: create("alu_seqr",this);
	   alu_driver = ALU_Driver :: type_id :: create("alu_driver",this);
	   alu_monitor = monitor :: type_id :: create("alu_monitor",this);
   endfunction
   
   virtual function void connect_phase (uvm_phase phase);
         super.connect_phase(phase);
         alu_driver.seq_item_port.connect(alu_seqr.seq_item_export);
   endfunction 
   
   task run_phase (uvm_phase phase);
		super.run_phase(phase);
   endtask
endclass
`endif
