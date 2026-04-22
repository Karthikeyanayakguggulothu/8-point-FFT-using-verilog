module tb_fft_8pt;

    localparam integer SCALE = 256;

    reg clk, reset, start;

    reg signed [15:0] x0_r, x0_i, x1_r, x1_i, x2_r, x2_i, x3_r, x3_i;
    reg signed [15:0] x4_r, x4_i, x5_r, x5_i, x6_r, x6_i, x7_r, x7_i;

    wire signed [15:0] X0_r, X0_i, X1_r, X1_i, X2_r, X2_i, X3_r, X3_i;
    wire signed [15:0] X4_r, X4_i, X5_r, X5_i, X6_r, X6_i, X7_r, X7_i;
    wire valid_out;

    fft_8pt_top uut (
        .clk(clk), .reset(reset), .start(start),
        .x0_r(x0_r), .x0_i(x0_i), .x1_r(x1_r), .x1_i(x1_i),
        .x2_r(x2_r), .x2_i(x2_i), .x3_r(x3_r), .x3_i(x3_i),
        .x4_r(x4_r), .x4_i(x4_i), .x5_r(x5_r), .x5_i(x5_i),
        .x6_r(x6_r), .x6_i(x6_i), .x7_r(x7_r), .x7_i(x7_i),
        .X0_r(X0_r), .X0_i(X0_i), .X1_r(X1_r), .X1_i(X1_i),
        .X2_r(X2_r), .X2_i(X2_i), .X3_r(X3_r), .X3_i(X3_i),
        .X4_r(X4_r), .X4_i(X4_i), .X5_r(X5_r), .X5_i(X5_i),
        .X6_r(X6_r), .X6_i(X6_i), .X7_r(X7_r), .X7_i(X7_i),
        .valid_out(valid_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0; reset = 1; start = 0;
        #20 reset = 0;

        x0_r = 1 * SCALE;  x0_i = 0;
        x1_r = 2 * SCALE;  x1_i = 0;
        x2_r = 3 * SCALE;  x2_i = 0;
        x3_r = 4 * SCALE;  x3_i = 0;
        x4_r = 5 * SCALE;  x4_i = 0;
        x5_r = 6 * SCALE;  x5_i = 0;
        x6_r = 7 * SCALE;  x6_i = 0;
        x7_r = 8 * SCALE;  x7_i = 0;

        #10 start = 1;
        #10 start = 0;

        wait(valid_out == 1);
        #1;

        $display("    8-point fft output    ");
        $display(" Bin   Real Part  Imaginary Part        ");
        $display(" X(0)  %9.4f   + j(%9.4f )", $itor(X0_r) / SCALE, $itor(X0_i) / SCALE);
        $display(" X(1)  %9.4f   + j(%9.4f )", $itor(X1_r) / SCALE, $itor(X1_i) / SCALE);
        $display(" X(2)  %9.4f   + j(%9.4f )", $itor(X2_r) / SCALE, $itor(X2_i) / SCALE);
        $display(" X(3)  %9.4f   + j(%9.4f )", $itor(X3_r) / SCALE, $itor(X3_i) / SCALE);
        $display(" X(4)  %9.4f   + j(%9.4f )", $itor(X4_r) / SCALE, $itor(X4_i) / SCALE);
        $display(" X(5)  %9.4f   + j(%9.4f )", $itor(X5_r) / SCALE, $itor(X5_i) / SCALE);
        $display(" X(6)  %9.4f   + j(%9.4f )", $itor(X6_r) / SCALE, $itor(X6_i) / SCALE);
        $display(" X(7)  %9.4f   + j(%9.4f )", $itor(X7_r) / SCALE, $itor(X7_i) / SCALE);
        
        #50 $finish;
    end
endmodule
