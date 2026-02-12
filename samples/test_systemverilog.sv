// SystemVerilog sample — LSP diagnostics & formatting demo
// Open in Zed with ChipKit to see Verible in action.
//
// What to try:
//   1. Check the Problems panel for lint diagnostics
//   2. Run "Format Document" to fix indentation
//   3. Open the symbol outline — packages, modules, classes, functions all appear
//   4. Use "Go to Symbol" to jump between definitions

// ── Package with types — shows in symbol outline ──────────────
package axi_pkg;
  typedef enum logic [1:0] {
    FIXED = 2'b00,
    INCR  = 2'b01,
    WRAP  = 2'b10
  } burst_t;

  typedef struct packed {
    logic [31:0] addr;
    logic [7:0]  len;
    burst_t      burst;
  } axi_req_t;

  function automatic logic [31:0] align_addr(input logic [31:0] addr, input int size);
    return addr & ~((1 << size) - 1);
  endfunction
endpackage

// ── Interface — Verible outlines ports and modports ───────────
interface axi_if #(parameter DW = 32) (input logic clk, input logic rst_n);
  logic        valid;
  logic        ready;
  logic [DW-1:0] data;

  modport master (output valid, output data, input  ready);
  modport slave  (input  valid, input  data, output ready);
endinterface

// ── Deliberately messy formatting ─────────────────────────────
// Run "Format Document" and watch Verible clean this up.
module axi_fifo
import axi_pkg::*;
#(  parameter DEPTH=4,
parameter DW   = 32
)(
  input logic clk,input logic rst_n,
    axi_if.slave  in,
  axi_if.master out
);

logic [DW-1:0] mem [DEPTH];
logic [$clog2(DEPTH)-1:0] wr_ptr,rd_ptr;
  logic [$clog2(DEPTH):0] count;

// ── Missing begin/end on multi-line if — Verible warns ──────
always_ff @(posedge clk or negedge rst_n)
  if (!rst_n) begin
    wr_ptr <= '0;
    rd_ptr <= '0;
  end
  // ── Case without default — Verible warns ────────────────────
  always_comb begin
    unique case (count)
      0       : out.valid = 1'b0;
      DEPTH   : in.ready  = 1'b0;
      default : begin
        out.valid = 1'b1;
        in.ready  = 1'b1;
      end
    endcase
  end

endmodule

// ── Class-based testbench — rich symbol outline ───────────────
class axi_transaction;
  rand logic [31:0] addr;
  rand logic [7:0]  data[];
  constraint c_size { data.size() inside {[1:16]}; }

  function void display();
    $display("[AXI] addr=0x%08h len=%0d", addr, data.size());
  endfunction
endclass

module tb;
  logic clk = 0;
  always #5 clk = ~clk;

  logic rst_n;
  axi_if #(.DW(32)) bus (.clk(clk), .rst_n(rst_n));

  axi_fifo #(.DEPTH(8), .DW(32)) dut (
    .clk   (clk),
    .rst_n (rst_n),
    .in    (bus),
    .out   (bus)
  );

  initial begin
    axi_transaction txn = new();
    rst_n = 0;
    #20 rst_n = 1;
    repeat (10) begin
      assert(txn.randomize());
      txn.display();
      @(posedge clk);
    end
    $finish;
  end
endmodule
