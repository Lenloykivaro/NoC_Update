module switch_module (
    input wire clk,
    input wire reset,
    input wire [31:0] vc0_data,
    input wire vc0_valid,
    input wire [31:0] vc1_data,
    input wire vc1_valid,
    output reg vc0_ready,
    output reg vc1_ready,
    input wire [1:0] selected_vc,
    output reg [31:0] out_data,
    output reg out_valid,
    input wire out_ready,
    output reg out_head,
    output reg out_tail,
    input wire vc0_head,
    input wire vc0_tail,
    input wire vc1_head,
    input wire vc1_tail
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        out_valid <= 1'b0;
    end
    else begin
        case (selected_vc)
            2'b00: begin
                if (vc0_valid && out_ready) begin
                    out_data <= vc0_data;
                    out_head <= vc0_head;
                    out_tail <= vc0_tail;
                    out_valid <= 1'b1;
                    vc0_ready <= 1'b1;
                end
                else begin
                    vc0_ready <= 1'b0;
                end
            end

            2'b01: begin
                if (vc1_valid && out_ready) begin
                    out_data <= vc1_data;
                    out_head <= vc1_head;
                    out_tail <= vc1_tail;
                    out_valid <= 1'b1;
                    vc1_ready <= 1'b1;
                end
                else begin
                    vc1_ready <= 1'b0;
                end
            end
        endcase

        // Clear the valid signal once the flit is sent
        if (out_valid && out_ready) begin
            out_valid <= 1'b0;
        end
    end
end
endmodule
