`timescale 1ns / 1ps



module Time_clock(
    input i_clk,
    input i_reset,
    input i_onoff,
    input i_modeSW,
    output [3:0] o_fnddigitposition,
    output [7:0] o_fndfont

    );
    wire w_clk_1KHz;
    wire [2:0] w_FNDcounter;
    wire [6:0] w_hour, w_min,w_sec;
    wire [6:0] w_msec;
    wire [3:0] w_min_1,w_min_10,w_hour_1,w_hour_10;
    wire [3:0] w_sec_1,w_sec_10,w_msec_1,w_msec_10;
    wire [3:0] w_hourMinMux,w_SecMsecMux;
    wire [3:0] w_fndValue;
    wire [3:0] w_fndDP;
    Clock_divider clockDiv(
    .i_clk(i_clk),
    .i_reset(i_reset),
    .o_clk(w_clk_1KHz)

    );

    counterFND countFND(
    .i_clk(w_clk_1KHz),
    .i_reset(i_reset),
    .o_counter(w_FNDcounter)

    );

    decoderFNDdigit decoder_fnd(
    .i_select(w_FNDcounter),
    .o_digitposition(o_fnddigitposition)

    );
    
    timeclockCounter timeclockcounter(
    .i_clk(w_clk_1KHz) ,
    .i_reset(i_reset),
    .o_hour(w_hour),
    .o_min(w_min),
    .o_sec(w_sec),
    .o_msec(w_msec)
    );

    digit_divider_hourmin Digit_div_Hourmin(
    .i_hour(w_hour),
    .i_min(w_min),
    .o_min_1(w_min_1),
    .o_min_10(w_min_10),
    .o_hour_1(w_hour_1),
    .o_hour_10(w_hour_10)

    );

    digit_divider_secmsec Digit_div_SecMsec(
    .i_sec(w_sec),
    .i_msec(w_msec),
    .o_sec_1(w_sec_1),
    .o_sec_10(w_sec_10),
    .o_msec_1(w_msec_1),
    .o_msec_10(w_msec_10)

    );

    Comparator Compare(
    .i_msec(w_msec),
    .o_fndDP(w_fndDP)
    );

    Mux_8x1 Mux_hour(
    .i_a(w_min_1),
    .i_b(w_min_10),
    .i_c(w_hour_1),
    .i_d(w_hour_10),
    .i_a1(11),
    .i_b1(11),
    .i_c1(w_fndDP),
    .i_d1(11),
    .i_sel(w_FNDcounter),
    .o_y(w_hourMinMux)

    );

    Mux_8x1 Sec(
    .i_a(w_msec_1),
    .i_b(w_msec_10),
    .i_c(w_sec_1),
    .i_d(w_sec_10),
    .i_a1(11),
    .i_b1(11),
    .i_c1(w_fndDP),
    .i_d1(11),
    .i_sel(w_FNDcounter),
    .o_y(w_SecMsecMux)

    );

    Mux_2x1 Mux_2X1(
    .i_a(w_SecMsecMux),
    .i_b(w_hourMinMux),
    .i_sel(i_modeSW),
    .o_y(w_fndValue)
    );


    BCDtoFND_decoder FND_font(
    .i_value(w_fndValue),
    .i_onoff(i_onoff),
    .o_font(o_fndfont)
    );
endmodule
