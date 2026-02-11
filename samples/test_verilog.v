// Verilog sample
`define WIDTH 8

module blinker (
  input wire clk,
  input wire rst_n,
  output reg led
);
  reg [7:0] counter;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      counter <= 8'h00;
      led <= 1'b0;
    end else begin
      counter <= counter + 8'd1;
      if (counter == 8'd255) begin
        led <= ~led;
      end
    end
  end
endmodule
