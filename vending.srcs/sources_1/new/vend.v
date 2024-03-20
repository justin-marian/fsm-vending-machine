`timescale 1ns / 1ps

module automat (
    input wire input_50bani,
    input wire input_1lei,
    input wire input_5lei,

    input wire reset,
    input wire clk,

    input wire get_product_x,
    input wire get_product_y,

    input wire change,

    output reg give_product_x,
    output reg give_product_y,
    
    output reg give_remaining_50bani,
    output reg [3:0] give_remaining_1lei
);

    parameter A = 2'b00; // idle
    parameter B = 2'b01; // money
    parameter C = 2'b10; // product & change

    reg [1:0] state;

    reg product_x;
    reg product_y;

    reg [1:0] next_state;
  
    reg [3:0] count;
    real sum;
  
    initial begin
        count = 4'b0000;
        sum = 0;

        next_state = 0;
        state = 0;

        give_product_x = 0;
        give_product_y = 0;

        give_remaining_50bani = 0;
        give_remaining_1lei = 0;

        product_x = 0;
        product_y = 0;
    end

    always @(posedge clk or negedge reset)
        if (!reset)   // idle state - A - reset
            state <= A;
        else
            state <= next_state;
  
    always @(*) begin
        assign give_product_x = 0;
        assign give_product_y = 0;

        assign give_remaining_50bani = 0;
        assign give_remaining_1lei = 0;

        case (state)
            A: begin
                next_state = A;

                if (input_50bani || input_1lei || input_5lei) begin
                    if (input_50bani) begin
                        if (sum + 0.5 >= 10) begin
                            next_state = C;
                        end
                        sum = sum + 0.5;
                    end
                    
                    if (input_1lei) begin
                        if (sum + 1 >= 10) begin
                            next_state = C;
                        end
                        sum = sum + 1.0;
                    end
                    
                    if (input_5lei) begin
                        if (sum + 5 >= 10) begin
                            next_state = C;
                        end
                        sum = sum + 5.0;
                    end
                end
                if (get_product_x || get_product_y) begin
                    next_state = B;
                    
                    if (get_product_x) begin
                        product_x = 1;
                    end
                    
                    if (get_product_y) begin
                        product_y = 1;
                    end
                end
                
                if (change) begin
                    next_state = C;
                end
                
                state = next_state;
            end

            B: begin
                if (product_x) begin
                
                    if (sum < 1.5) begin
                        next_state = A;
                    end else begin 
                        sum = sum - 1.5;
                        assign give_product_x = 1;
                    end
                    
                end else begin
                    next_state = A;
                end
                if (product_y) begin
                
                    if (sum < 3) begin
                        next_state = A;
                    end else begin 
                        sum = sum - 3;
                        assign give_product_y = 1;
                    end
 
                end else begin
                    next_state = A;
                end
                
                product_x = 0;
                product_y = 0;

                state = next_state;
            end
 
            C: begin
                count = 4'b0000;
                while (sum >= 1.0) begin
                    sum = sum - 1.0;
                    count = count + 1;
                end

                $display("restul este de %d lei", count);
                assign give_remaining_1lei = count;

                if (sum) begin
                    $display("si 50 de bani\n");
                    assign give_remaining_50bani = 1;
                    sum = 0;
                end
                
                next_state = A;
                state = next_state;
            end
        endcase
    end
endmodule
