`timescale 1ns / 1ps



module tb_time_clock();
    reg i_clk = 0;
    reg i_reset = 0;
    reg i_modeSW = 0;
    wire [3:0] o_fnddigitposition;
    wire [7:0] o_fndfont;

    

    Time_clock dut(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .i_modeSW(i_modeSW),
        .o_fnddigitposition(o_fnddigitposition),
        .o_fndfont(o_fndfont)

    );

    always #5 i_clk = ~i_clk;

    initial begin
        #00000 i_modeSW = 1'b0;
        #10000 i_modeSW = 1'b1;
        #10000 i_modeSW = 1'b0;
        #10000 i_modeSW = 1'b1;
        #10000 i_modeSW = 1'b0;
        #10000 $finish;
    end
endmodule
