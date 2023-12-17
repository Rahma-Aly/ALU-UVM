`ifndef ALU_DRIVER_SV
`define ALU_DRIVER_SV

`include "uvm_macros.svh"
`include "ALU_Transaction.sv"
import uvm_pkg::*;

class ALU_Driver extends uvm_driver #(ALU_Transaction);
  `uvm_component_utils(ALU_Driver)
   virtual ALU_interface                alu_vi;  //virtual interface
   
   
   function new (string name = "ALU Driver", uvm_component parent = null);
       super.new(name,parent);
   endfunction

   virtual function void build_phase (uvm_phase phase);
       super.build_phase(phase);
       if (!uvm_config_db #(virtual ALU_interface) :: get (this,"*","ALU_interface",alu_vi)) begin
           `uvm_fatal(get_type_name(),"Virtul Interface not found") //Didn't get handle to virtual interface alu_vi
       end
   endfunction
   
   function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
	endfunction
	
   virtual task run_phase (uvm_phase phase);
    ALU_Transaction  alu_trans;
    forever begin
	   alu_trans = ALU_Transaction ::type_id :: create("alu_trans",this);
       //get next item from sequencer 
       seq_item_port.get_next_item (alu_trans);
       //assign received data to virtual interface
       alu_vi.in1       <= alu_trans.in1;
       alu_vi.in2       <= alu_trans.in2;
       alu_vi.opcode    <= alu_trans.opcode;
       alu_vi.out       <= alu_trans.out; 

       //finish driving transaction
       seq_item_port.item_done();
    end
   endtask

endclass


`endif
