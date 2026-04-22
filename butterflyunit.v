module butterfly_simple #(parameter WIDTH = 16)(
    input  wire signed [WIDTH-1:0] a_r, a_i,
    input  wire signed [WIDTH-1:0] b_r, b_i,
    output wire signed [WIDTH-1:0] x_r, x_i,
    output wire signed [WIDTH-1:0] y_r, y_i
);
    assign x_r = a_r + b_r;
    assign x_i = a_i + b_i;
    assign y_r = a_r - b_r;
    assign y_i = a_i - b_i;
endmodule

module butterfly_complex #(parameter WIDTH = 16)(
    input  wire signed [WIDTH-1:0] a_r, a_i,
    input  wire signed [WIDTH-1:0] b_r, b_i,
    input  wire signed [WIDTH-1:0] w_r, w_i,
    output wire signed [WIDTH-1:0] x_r, x_i,
    output wire signed [WIDTH-1:0] y_r, y_i
);
    wire signed [WIDTH-1:0] bw_r, bw_i;
    wire signed [WIDTH-1:0] mult1, mult2, mult3, mult4;

    fixed_mult #(.WIDTH(WIDTH)) m1 (.a(b_r), .b(w_r), .result(mult1));
    fixed_mult #(.WIDTH(WIDTH)) m2 (.a(b_i), .b(w_i), .result(mult2));
    fixed_mult #(.WIDTH(WIDTH)) m3 (.a(b_r), .b(w_i), .result(mult3));
    fixed_mult #(.WIDTH(WIDTH)) m4 (.a(b_i), .b(w_r), .result(mult4));

    assign bw_r = mult1 - mult2;
    assign bw_i = mult3 + mult4;

    assign x_r = a_r + bw_r;
    assign x_i = a_i + bw_i;
    assign y_r = a_r - bw_r;
    assign y_i = a_i - bw_i;
endmodule
