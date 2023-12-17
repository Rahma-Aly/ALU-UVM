`ifndef MONITOR_SV
`define MONITOR_SV

`include "uvm_macros.svh"
`include "ALU_Transaction.sv"
import uvm_pkg::*;

class monitor extends uvm_monitor;
 `uvm_component_utils(monitor)  //to make the monitor re-usable -> register with the factory 
  virtual ALU_interface                alu_vi;  //virtual interface
  ALU_Transaction                      alu_trans;
  uvm_analysis_port #(ALU_Transaction) ap; //analysis port 

  function new (string name = "ALU Monitor", uvm_component parent = null);
      super.new(name,parent);
  endfunction
  //virtual functions to allow overriding it
  //build the monitor 
  virtual function void build_phase (uvm_phase phase);
   super.build_phase(phase);
   if (!uvm_config_db #(virtual ALU_interface) :: get (this,"*","ALU_interface",alu_vi)) begin
      `uvm_error (get_type_name(),"Virtul Interface not found")
   end
   ap = new("ap",this);  //an instance of the declared analysis port
   endfunction
   
   function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
   endfunction
   
   //run_phase
   virtual task run_phase (uvm_phase phase);
	 super.run_phase(phase);
        while(1) begin
			alu_trans       = ALU_Transaction :: type_id :: create("alu_trans");
            #100
            alu_trans.in1   = alu_vi.in1;
            alu_trans.in2   = alu_vi.in2;
            alu_trans.opcode= alu_vi.opcode;
            alu_trans.out   = alu_vi.out;
			#1
          //  alu_trans.convert2string();
            ap.write(alu_trans); //send captured information to subscribers through analysis port
         end
   endtask

endclass
  
`endif
