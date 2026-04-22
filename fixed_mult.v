module fixed_mult #(
    parameter WIDTH = 16,
    parameter FBITS = 8
)(
    input  wire signed [WIDTH-1:0] a,
    input  wire signed [WIDTH-1:0] b,
    output wire signed [WIDTH-1:0] result
);
    wire signed [(2*WIDTH)-1:0] mult_full;
    assign mult_full = a * b;
 
    assign result = mult_full[WIDTH + FBITS - 1 : FBITS];
endmodule
