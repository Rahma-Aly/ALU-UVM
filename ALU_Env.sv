`ifndef ALU_ENV_SV
`define ALU_ENV_SV

`include "uvm_macros.svh"
`include "ALU_Agent.sv"
`include "ALU_Scoreboard.sv"
`include "Coverage.sv"
import uvm_pkg::*;

class ALU_Env extends uvm_env;
  `uvm_component_utils(ALU_Env)
   ALU_Agent                    alu_agnt;
   ALU_Scoreboard               alu_scrbrd;
   Coverage                     alu_coverage;

  function new (string name = "ALU_Env", uvm_component parent = null);
      super.new(name,parent);
  endfunction

  virtual function void build_phase (uvm_phase phase);
       super.build_phase(phase);
       alu_agnt     = ALU_Agent::type_id::create("alu_agnt",this);
       alu_scrbrd   = ALU_Scoreboard ::type_id::create ("alu_scrbrd",this);
       alu_coverage = Coverage :: type_id::create("alu_coverage",this);
  endfunction

  virtual function void connect_phase (uvm_phase phase);
       super.connect_phase(phase);
       alu_agnt.alu_monitor.ap.connect(alu_scrbrd.analysis_export);
       alu_agnt.alu_monitor.ap.connect(alu_coverage.analysis_export); 
  endfunction


  task run_phase (uvm_phase phase);
    super.run_phase(phase);
  endtask: run_phase
endclass
`endif
