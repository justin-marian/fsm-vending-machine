`timescale 1ns / 1ps

module sim_1;
    reg input_50bani;
    reg input_1lei;
    reg input_5lei;
    reg reset;
    reg clk;
    reg get_product_x;
    reg get_product_y;
    reg change;
  
    wire give_product_x;
    wire give_product_y;
    wire give_remaining_50bani;
    wire [3:0] give_remaining_1lei;
    
    automat dut (
        .input_50bani(input_50bani),
        .input_1lei(input_1lei),
        .input_5lei(input_5lei),
        .reset(reset),
        .get_product_x(get_product_x),
        .get_product_y(get_product_y),
        .change(change),
        .give_product_x(give_product_x),
        .give_product_y(give_product_y),
        .give_remaining_50bani(give_remaining_50bani),
        .give_remaining_1lei(give_remaining_1lei)
    );
    
    always begin
        #5 clk = ~clk;
    end
    
    initial begin
        clk = 0;
        input_50bani = 0;
        input_1lei = 0;
        input_5lei = 0;
        reset = 0;
        get_product_x = 0;
        get_product_y = 0;
        change = 0;

        $display("TEST\n");
        #20 reset = 0;
        #20 input_50bani = 1; // + 0.5
        #20 input_50bani = 0;
        #20 input_5lei = 1; // + 5
        #20 input_5lei = 0;
        #20 input_5lei = 1; // +5
        #20 input_5lei = 0;
        #20 input_50bani = 1; // + 0.5
        #20 input_50bani = 0;
        #20 get_product_x = 1; // - 1.5
        #20 get_product_x = 0;
        #20 input_5lei = 1; // + 5
        #20 input_5lei = 0;
        #20 get_product_y = 1; // - 3
        #20 get_product_y = 0;
        #20 input_50bani = 1; // + 0.5
        #20 input_50bani = 0;
        #20 change = 1; // nr_1 + 1/0 = nr_05
        #20 change = 0;
        #20 $finish;
    end
endmodule