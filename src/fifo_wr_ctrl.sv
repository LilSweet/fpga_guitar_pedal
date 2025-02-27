`timescale 1 ns/ 1 ns
module fifo_wr_ctrl #(
  I2S_MODE        = 1'b0
)(
  input            resetn,
  input            bclk,
  input            sync,
  output logic     latch,
  output logic     wr_en
);

localparam BIT_COUNT_MAX = 24;
localparam BIT_COUNT_WIDTH = $clog2(BIT_COUNT_MAX);

logic [BIT_COUNT_MAX - 1:0] bit_count;
logic [3:0] sync_reg;

typedef enum logic [1:0] {
  IDLE,
  SYNC,
  COUNT,
  WRITE
} state_t;

state_t next_state, current_state;

always_ff @(posedge bclk) begin
  if (!resetn) begin
    bit_count     <= 0;
    current_state <= IDLE;
    sync_reg      <= 0;
  end else begin

    sync_reg <= {sync_reg[2:0], sync};

    current_state <= next_state;

    case (current_state)
      IDLE: begin
        bit_count <= 0;
      end

      SYNC: begin
        bit_count <= 0;
      end

      COUNT: begin
        if(bit_count < BIT_COUNT_MAX ) begin
          bit_count <= bit_count + 1'b1;
        end else begin
          bit_count <= 0;
        end
      end

      WRITE: begin
        bit_count <= 0;
      end

    endcase

  end
end

always_comb begin
  next_state = IDLE;
  wr_en = 1'b0;
  latch = 1'b0;

  case (current_state)
    IDLE: begin
      if (!sync_reg[3] && sync_reg[2]) begin
        if (!I2S_MODE) begin
          next_state = COUNT;
        end else begin
          next_state = SYNC;
        end
      end else begin
        next_state = SYNC;
      end
    end

    SYNC: begin
      next_state = COUNT;
    end

    COUNT: begin
      if (bit_count == BIT_COUNT_MAX) begin
        latch = 1'b1; 
        next_state = WRITE;
      end else begin
        latch = 1'b0;
      end
    end

    WRITE: begin
      wr_en = 1'b1;
      next_state = IDLE;
    end
  endcase

end

endmodule