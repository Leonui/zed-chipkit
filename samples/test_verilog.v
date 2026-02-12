// Verilog sample — LSP diagnostics & formatting demo
// Open in Zed with ChipKit to see Verible in action.
//
// What to try:
//   1. Check the Problems panel for lint diagnostics
//   2. Run "Format Document" to fix indentation
//   3. Open the symbol outline (Cmd/Ctrl+Shift+O)

`define DATA_W 8

// ── Deliberately messy formatting ──────────────────────────────
// Verible's formatter will clean up alignment and indentation.
module counter(
input wire clk,
input wire rst_n,
    input wire       enable,
  output reg [`DATA_W-1:0] count,
      output wire overflow
);

assign overflow=( count == {`DATA_W{1'b1}} );

always @( posedge clk or negedge rst_n)
begin
if(!rst_n)
count <= {`DATA_W{1'b0}};
else if(enable)
count <= count + 1;
end

endmodule

// ── Missing default in case — Verible warns ───────────────────
module decoder (
  input  wire [1:0] sel,
  output reg  [3:0] out
);
  always @(*) begin
    case (sel)
      2'b00: out = 4'b0001;
      2'b01: out = 4'b0010;
      2'b10: out = 4'b0100;
      // no 2'b11 and no default — Verible flags this
    endcase
  end
endmodule

// ── Top-level wiring — symbol outline shows hierarchy ─────────
module top (
  input  wire       clk,
  input  wire       rst_n,
  output wire [3:0] decoded
);
  wire [`DATA_W-1:0] cnt;
  wire                ovf;

  counter u_cnt (
    .clk    (clk),
    .rst_n  (rst_n),
    .enable (1'b1),
    .count  (cnt),
    .overflow(ovf)
  );

  decoder u_dec (
    .sel (cnt[1:0]),
    .out (decoded)
  );
endmodule
