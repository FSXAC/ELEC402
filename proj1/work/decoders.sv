/* The higher the setting (fstop), the smaller the light */
/* Therefore we need to subtract from maximum setting */
module aperture_decoder(
    input logic [2:0] input_setting,
    output logic [7:0] output_multiplier
);
    assign output_multiplier = 1 << (7 - input_setting);
endmodule

/* For shutter speed, the higher the setting */
/* the faster the shutter speed */
/* Therefore we need to subtract from the maximum setting */
module shutter_decoder(
    input logic [2:0] input_setting,
    output logic [31:0] shutter_wait_time
);
    parameter BASE_WAIT_CYCLE = 2;
    assign shutter_wait_time = BASE_WAIT_CYCLE << (7 - input_setting);
endmodule