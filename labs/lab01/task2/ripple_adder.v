// ripple_adder.v
// Structural 4-bit ripple-carry adder, built from four FA_Gate instances.
// (Delays live inside FA_Gate.v -- nothing here needs a delay of its own.)
//
// TODO: instantiate four FA_Gate modules (name them FA0..FA3) and connect
// them into a ripple-carry chain, matching the pattern from lecture:
//
//   FA0: a[0], b[0], cin  -> sum[0], c1
//   FA1: a[1], b[1], c1   -> sum[1], c2
//   FA2: a[2], b[2], c2   -> sum[2], c3
//   FA3: a[3], b[3], c3   -> sum[3], cout
//
// Use named port connections (.a(...), .b(...), etc.), not positional.

// ripple_adder.v
module ripple_adder #(parameter WIDTH = 4) (
  input  [WIDTH-1:0] a,
  input  [WIDTH-1:0] b,
  input               cin,
  output [WIDTH-1:0] sum,
  output              cout
);
  wire [WIDTH:0] carry;
  assign carry[0] = cin;

  genvar i;
  generate
    for (i = 0; i < WIDTH; i = i + 1) begin : FA_STAGE
      FA_Gate fa_inst (
        .a    (a[i]),
        .b    (b[i]),
        .cin  (carry[i]),
        .sum  (sum[i]),
        .cout (carry[i+1])
      );
    end
  endgenerate

  assign cout = carry[WIDTH];

endmodule