// SystemVerilog sample
package pkt_pkg;
  typedef struct packed {
    logic [7:0] id;
    logic [31:0] data;
  } packet_t;
endpackage

module tb;
  import pkt_pkg::*;

  class driver;
    rand packet_t pkt;
    function void send();
      $display("id=%0d data=%0h", pkt.id, pkt.data);
    endfunction
  endclass

  initial begin
    driver d = new();
    assert(d.randomize());
    d.send();
  end
endmodule
