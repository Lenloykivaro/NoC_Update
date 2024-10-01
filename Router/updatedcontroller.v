module controller_module (
    input clk,
    input reset,
    input vc0_valid,
    input vc1_valid,
    output reg selected_vc // 0 for VC0, 1 for VC1
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            selected_vc <= 0; // Default to VC0
        end else begin
            // Simple round-robin or priority-based selection
            if (vc0_valid) begin
                selected_vc <= 0;
            end else if (vc1_valid) begin
                selected_vc <= 1;
            end
        end
    end
endmodule
