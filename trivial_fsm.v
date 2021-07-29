

module main (
    input reset,
    input start,
    input clk,
    output [4:0] out,
    output ready
);
    parameter state_one = 0;
    parameter state_two = 1;
    parameter state_three = 2;
    parameter state_four = 3;
    parameter state_five = 4;

    reg[11:0] current_state;
    reg[11:0] next_state;

    always @(posedge clk) begin
        if (reset)==1'b1 begin
            current_state <= state_one;
        end
        else if (start==1'b1) begin
            current_state <= next_state;
        end
        else begin
            current_state <= current_state;
        end
    end

    always @(*) begin
        case (current_state) begin
            state_one : begin
                next_state = state_two;
            end
            state_two : begin
                next_state = state_three;
            end
            state_three : begin
                next_state = state_four;
            end
            state_four : begin
                next_state = state_five;
            end
            state_five : begin
                next_state = state_five;
            end
            default : begin
                next_state = state_one;
            end
        endcase

    end

    assign out = current_state[4:0];
    assign ready = (current_state==state_five);

endmodule



