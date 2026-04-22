module fft_controller (
    input wire clk,
    input wire reset,
    input wire start,       
    output wire enable,     
    output wire valid_out   
);
    reg [2:0] valid_shift_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            valid_shift_reg <= 3'b000;
        end else begin
            valid_shift_reg[0] <= start;             
            valid_shift_reg[1] <= valid_shift_reg[0];
            valid_shift_reg[2] <= valid_shift_reg[1];
        end
    end

    assign valid_out = valid_shift_reg[2];
    assign enable = (start | valid_shift_reg[0] | valid_shift_reg[1] | valid_shift_reg[2]);
endmodule
