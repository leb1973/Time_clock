`timescale 1ns / 1ps



module tb_timeclockcounter();
    reg i_reset;
    reg i_clk = 1'b0;
    wire[5:0] o_hour, o_min, o_sec;
    wire[6:0] o_msec;

    timeclockCounter dut(
        .i_clk(i_clk),
        .i_reset(i_reset),
        .o_hour(o_hour),
        .o_min(o_min),
        .o_sec(o_sec),
        .o_msec(o_msec)

    );

    always #5 i_clk = ~i_clk;

    initial begin
        #00 i_reset =1'b1;
        #100 i_reset = 1'b0;
        #5000 i_reset = 1'b1;
        #100 i_reset = 1'b0;
        #5000 $finish;
    end




endmodule
