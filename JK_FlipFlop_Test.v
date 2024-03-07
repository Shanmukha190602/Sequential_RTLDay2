`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.03.2024 11:14:54
// Design Name: 
// Module Name: JK_FlipFlop_Test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module JK_FlipFlop_Test();

  // Parameters
    parameter CLK_PERIOD = 10; // Clock period in nanoseconds

    // Signals
    reg clk;
    reg reset;
    reg J, K;
    wire q, q_bar;
    
    // Instantiate the module under test
    JK_FlipFlop Dut (
        .clk(clk),
        .reset(reset),
        .j(J),
        .k(K),
        .q(q),
        .q_bar(q_bar)
    );
    
     // Clock generation
    always #((CLK_PERIOD)/2) clk = ~clk;

    // Initial values
    initial begin
        clk = 0;
        reset = 1;
        J = 0;
        K = 0;
        #20 reset = 0; // Release reset after 20 ns
    end

    // Stimulus
    initial begin
        #30 J = 1; K = 0; // Set J input to 1
        #10 J = 0; K = 0; // Set J input to 0
        #10 J = 0; K = 1; // Set K input to 1
        #10 J = 0; K = 0; // Set K input to 0
        #10 J = 1; K = 1; // Complement of q output
        #10 J = 0; K = 0; // Set inputs back to 0
    end

    // Display output
    always @ (posedge clk) begin
        $monitor($time," J = %b, K = %b, q = %b, q_bar = %b", J, K, q, q_bar);
        #100 $finish; 
    end
        
endmodule
