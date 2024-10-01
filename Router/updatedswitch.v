module switch_module (
    input clk,
    input reset,
    input [7:0] vc0_data,
    input [7:0] vc1_data,
    input vc0_valid,
    input vc1_valid,
    output reg [7:0] out_data,
    output reg valid_out
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out_data <= 0;
            valid_out <= 0;
        end else begin
            if (vc0_valid) begin
                out_data <= vc0_data; // Forward data from VC0
                valid_out <= 1;
            end else if (vc1_valid) begin
                out_data <= vc1_data; // Forward data from VC1
                valid_out <= 1;
            end else begin
                valid_out <= 0; // No valid data to send
            end
        end
    end
endmodule

