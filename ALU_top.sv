`include "definitions.sv"
`include "uvm_macros.svh"
`include "ALU_Test.sv"

import uvm_pkg::*;
import definitions::*;
module ALU_top();

ALU_interface alu_i();

ALU  #( .DATASIZE(DATASIZE), .OUTPUT_SIZE(OUTPUT_SIZE))
 u1(
    .in1(alu_i.in1),
    .in2(alu_i.in2),
    .opcode(alu_i.opcode),
    .result(alu_i.out)
);

 initial begin
      uvm_config_db # (virtual ALU_interface)::set(null,"uvm_test_top","ALU_interface",alu_i);
      run_test("ALU_Test");
  end
endmodule
