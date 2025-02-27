`timescale 1 ns / 1 ns
module pld_hb(
    input       clk,
    input       resetn,
    output      hb_led
);

localparam COUNT_MAX   = 33554432;
localparam COUNT_WIDTH = $clog2(COUNT_MAX);

logic [COUNT_WIDTH - 1:0] count;

always_ff @(posedge clk or negedge resetn) begin
    if (!resetn) begin 
        count <= 0;
    end else begin
        count <= count + 1'b1;
    end   
end

assign hb_led = count[COUNT_WIDTH - 1];

endmodule