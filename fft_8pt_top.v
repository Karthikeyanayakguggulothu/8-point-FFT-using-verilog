module fft_8pt_top #(parameter WIDTH = 16)(
    input wire clk,
    input wire reset,
    input wire start,
    
    input wire signed [WIDTH-1:0] x0_r, x0_i,
    input wire signed [WIDTH-1:0] x1_r, x1_i,
    input wire signed [WIDTH-1:0] x2_r, x2_i,
    input wire signed [WIDTH-1:0] x3_r, x3_i,
    input wire signed [WIDTH-1:0] x4_r, x4_i,
    input wire signed [WIDTH-1:0] x5_r, x5_i,
    input wire signed [WIDTH-1:0] x6_r, x6_i,
    input wire signed [WIDTH-1:0] x7_r, x7_i,

    output reg signed [WIDTH-1:0] X0_r, X0_i, X1_r, X1_i, X2_r, X2_i, X3_r, X3_i,
    output reg signed [WIDTH-1:0] X4_r, X4_i, X5_r, X5_i, X6_r, X6_i, X7_r, X7_i,
    
    output wire valid_out
);

    wire enable;
    fft_controller ctrl (.clk(clk), .reset(reset), .start(start), .enable(enable), .valid_out(valid_out));

    wire signed [WIDTH-1:0] w0_r = 16'd256, w0_i =  16'd0;
    wire signed [WIDTH-1:0] w1_r = 16'd181, w1_i = -16'd181;
    wire signed [WIDTH-1:0] w2_r = 16'd0,   w2_i = -16'd256;
    wire signed [WIDTH-1:0] w3_r =-16'd181, w3_i = -16'd181;

    wire signed [WIDTH-1:0] s1_out_r [0:7], s1_out_i [0:7];
    wire signed [WIDTH-1:0] s2_out_r [0:7], s2_out_i [0:7];
    wire signed [WIDTH-1:0] s3_out_r [0:7], s3_out_i [0:7];
    
    reg signed [WIDTH-1:0] reg1_r [0:7], reg1_i [0:7];
    reg signed [WIDTH-1:0] reg2_r [0:7], reg2_i [0:7];
    integer i;

    butterfly_simple b1_0 (.a_r(x0_r), .a_i(x0_i), .b_r(x4_r), .b_i(x4_i), .x_r(s1_out_r[0]), .x_i(s1_out_i[0]), .y_r(s1_out_r[1]), .y_i(s1_out_i[1]));
    butterfly_simple b1_1 (.a_r(x2_r), .a_i(x2_i), .b_r(x6_r), .b_i(x6_i), .x_r(s1_out_r[2]), .x_i(s1_out_i[2]), .y_r(s1_out_r[3]), .y_i(s1_out_i[3]));
    butterfly_simple b1_2 (.a_r(x1_r), .a_i(x1_i), .b_r(x5_r), .b_i(x5_i), .x_r(s1_out_r[4]), .x_i(s1_out_i[4]), .y_r(s1_out_r[5]), .y_i(s1_out_i[5]));
    butterfly_simple b1_3 (.a_r(x3_r), .a_i(x3_i), .b_r(x7_r), .b_i(x7_i), .x_r(s1_out_r[6]), .x_i(s1_out_i[6]), .y_r(s1_out_r[7]), .y_i(s1_out_i[7]));

    butterfly_complex b2_0 (.a_r(reg1_r[0]), .a_i(reg1_i[0]), .b_r(reg1_r[2]), .b_i(reg1_i[2]), .w_r(w0_r), .w_i(w0_i), .x_r(s2_out_r[0]), .x_i(s2_out_i[0]), .y_r(s2_out_r[2]), .y_i(s2_out_i[2]));
    butterfly_complex b2_1 (.a_r(reg1_r[1]), .a_i(reg1_i[1]), .b_r(reg1_r[3]), .b_i(reg1_i[3]), .w_r(w2_r), .w_i(w2_i), .x_r(s2_out_r[1]), .x_i(s2_out_i[1]), .y_r(s2_out_r[3]), .y_i(s2_out_i[3]));
    butterfly_complex b2_2 (.a_r(reg1_r[4]), .a_i(reg1_i[4]), .b_r(reg1_r[6]), .b_i(reg1_i[6]), .w_r(w0_r), .w_i(w0_i), .x_r(s2_out_r[4]), .x_i(s2_out_i[4]), .y_r(s2_out_r[6]), .y_i(s2_out_i[6]));
    butterfly_complex b2_3 (.a_r(reg1_r[5]), .a_i(reg1_i[5]), .b_r(reg1_r[7]), .b_i(reg1_i[7]), .w_r(w2_r), .w_i(w2_i), .x_r(s2_out_r[5]), .x_i(s2_out_i[5]), .y_r(s2_out_r[7]), .y_i(s2_out_i[7]));

    butterfly_complex b3_0 (.a_r(reg2_r[0]), .a_i(reg2_i[0]), .b_r(reg2_r[4]), .b_i(reg2_i[4]), .w_r(w0_r), .w_i(w0_i), .x_r(s3_out_r[0]), .x_i(s3_out_i[0]), .y_r(s3_out_r[4]), .y_i(s3_out_i[4]));
    butterfly_complex b3_1 (.a_r(reg2_r[1]), .a_i(reg2_i[1]), .b_r(reg2_r[5]), .b_i(reg2_i[5]), .w_r(w1_r), .w_i(w1_i), .x_r(s3_out_r[1]), .x_i(s3_out_i[1]), .y_r(s3_out_r[5]), .y_i(s3_out_i[5]));
    butterfly_complex b3_2 (.a_r(reg2_r[2]), .a_i(reg2_i[2]), .b_r(reg2_r[6]), .b_i(reg2_i[6]), .w_r(w2_r), .w_i(w2_i), .x_r(s3_out_r[2]), .x_i(s3_out_i[2]), .y_r(s3_out_r[6]), .y_i(s3_out_i[6]));
    butterfly_complex b3_3 (.a_r(reg2_r[3]), .a_i(reg2_i[3]), .b_r(reg2_r[7]), .b_i(reg2_i[7]), .w_r(w3_r), .w_i(w3_i), .x_r(s3_out_r[3]), .x_i(s3_out_i[3]), .y_r(s3_out_r[7]), .y_i(s3_out_i[7]));

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for(i=0; i<8; i=i+1) begin 
                reg1_r[i] <= 0; reg1_i[i] <= 0; 
                reg2_r[i] <= 0; reg2_i[i] <= 0; 
            end
            X0_r <= 0; X0_i <= 0; X1_r <= 0; X1_i <= 0; X2_r <= 0; X2_i <= 0; X3_r <= 0; X3_i <= 0;
            X4_r <= 0; X4_i <= 0; X5_r <= 0; X5_i <= 0; X6_r <= 0; X6_i <= 0; X7_r <= 0; X7_i <= 0;
        end else if (enable) begin
            for(i=0; i<8; i=i+1) begin 
                reg1_r[i] <= s1_out_r[i]; reg1_i[i] <= s1_out_i[i]; 
                reg2_r[i] <= s2_out_r[i]; reg2_i[i] <= s2_out_i[i]; 
            end
            X0_r <= s3_out_r[0]; X0_i <= s3_out_i[0]; X1_r <= s3_out_r[1]; X1_i <= s3_out_i[1];
            X2_r <= s3_out_r[2]; X2_i <= s3_out_i[2]; X3_r <= s3_out_r[3]; X3_i <= s3_out_i[3];
            X4_r <= s3_out_r[4]; X4_i <= s3_out_i[4]; X5_r <= s3_out_r[5]; X5_i <= s3_out_i[5];
            X6_r <= s3_out_r[6]; X6_i <= s3_out_i[6]; X7_r <= s3_out_r[7]; X7_i <= s3_out_i[7];
        end
    end
endmodule
