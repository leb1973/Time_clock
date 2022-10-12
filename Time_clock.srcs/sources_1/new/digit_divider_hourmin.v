`timescale 1ns / 1ps



module digit_divider_hourmin(
    input [6:0] i_hour,i_min,
    output [3:0] o_min_1,o_min_10,o_hour_1,o_hour_10

    );

    assign o_min_1 = i_min % 10;
    assign o_min_10 = i_min / 10 % 10;

    assign o_hour_1 = i_hour % 10;
    assign o_hour_10 = i_hour /10 % 10; 
endmodule
