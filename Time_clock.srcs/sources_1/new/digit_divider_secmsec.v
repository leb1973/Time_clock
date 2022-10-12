`timescale 1ns / 1ps


module digit_divider_secmsec(
    input [6:0] i_sec,
    input [6:0] i_msec,
    output [3:0] o_sec_1,o_sec_10,o_msec_1,o_msec_10

    );

    assign o_msec_1 = i_msec % 10;
    assign o_msec_10 = i_msec / 10 % 10;

    assign o_sec_1 = i_sec % 10;
    assign o_sec_10 = i_sec /10 % 10; 
    
endmodule
