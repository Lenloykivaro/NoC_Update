module router_module (
    input clk,
    input reset,
    input [7:0] in_data,
    input in_valid,
    output [7:0] out_data,
    output valid_out
);
    wire [7:0] vc0_out, vc1_out;
    wire vc0_valid, vc1_valid;
    wire selected_vc;

    // Instantiate VC modules
    vc_module vc0 (
        .clk(clk),
        .reset(reset),
        .in_valid(in_valid),
        .in_data(in_data),
        .head(in_data[7:0] == 8'b11111111), // Example condition for head
        .tail(in_data[7:0] == 8'b00000000), // Example condition for tail
        .out_data(vc0_out),
        .valid_out(vc0_valid),
        .vc_full()
    );

    vc_module vc1 (
        .clk(clk),
        .reset(reset),
        .in_valid(in_valid),
        .in_data(in_data),
        .head(in_data[7:0] == 8'b11111111),
        .tail(in_data[7:0] == 8'b00000000),
        .out_data(vc1_out),
        .valid_out(vc1_valid),
        .vc_full()
    );

    // Instantiate Switch module
    switch_module switch_inst (
        .clk(clk),
        .reset(reset),
        .vc0_data(vc0_out),
        .vc1_data(vc1_out),
        .vc0_valid(vc0_valid),
        .vc1_valid(vc1_valid),
        .out_data(out_data),
        .valid_out(valid_out)
    );

    // Instantiate Controller module
    controller_module controller_inst (
        .clk(clk),
        .reset(reset),
        .vc0_valid(vc0_valid),
        .vc1_valid(vc1_valid),
        .selected_vc(selected_vc)
    );
endmodule
