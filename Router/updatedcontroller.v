module controller_module (
    input wire clk,
    input wire reset,
    input wire vc0_valid,
    input wire vc1_valid,
    output reg [1:0] selected_vc
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        selected_vc <= 2'b00;
    end
    else begin
        // Priority to VC0, if it's valid
        if (vc0_valid) begin
            selected_vc <= 2'b00;
        end
        else if (vc1_valid) begin
            selected_vc <= 2'b01;
        end
    end
end
endmodule
