module spi_wb_wrapper (
    `ifdef USE_POWER_PINS inout VPWR, inout VGND, `endif
    // Wishbone Ports
    input wb_clk_i, input wb_rst_i,
    input wbs_stb_i, input wbs_cyc_i, input wbs_we_i,
    input [3:0] wbs_sel_i, input [31:0] wbs_dat_i, input [31:0] wbs_adr_i,
    output wbs_ack_o, output [31:0] wbs_dat_o,

    // SPI Ports (Lấy đầy đủ từ spi_wrapper)
    input        spi_cs_n,
    input        spi_clk,
    input        spi_mosi,
    output       spi_miso,
    input [1:0]  spi_mode // Bổ sung thêm chân mode để linh hoạt
);

    wire [63:0] config_net; // SPI xuất ra -> Wishbone đọc
    reg  [63:0] status_reg; // Wishbone ghi -> SPI nhận

    // Khởi tạo lõi SPI
    spi_wrapper #(.NUM_CFG(8), .NUM_STATUS(8), .REG_WIDTH(8)) spi_core (
        .rstb(!wb_rst_i),
        .clk(wb_clk_i),
        .ena(1'b1),           // Luôn enable để giữ thanh ghi
        .mode(spi_mode),      // Lấy từ chân ngoài
        .spi_cs_n(spi_cs_n),
        .spi_clk(spi_clk),
        .spi_mosi(spi_mosi),
        .spi_miso(spi_miso),
        .config_regs(config_net),
        .status_regs(status_reg) 
    );

    // Logic Wishbone Ghi -> status_reg (để SPI truyền ra ngoài)
    always @(posedge wb_clk_i) begin
        if (wb_rst_i) status_reg <= 64'b0;
        else if (wbs_cyc_i && wbs_stb_i && wbs_we_i) begin
            if (wbs_adr_i[2] == 1'b0) status_reg[31:0]  <= wbs_dat_i;
            else                      status_reg[63:32] <= wbs_dat_i;
        end
    end

    // Logic Wishbone Đọc -> config_net (đọc những gì SPI nhận được)
    assign wbs_dat_o = (wbs_adr_i[2] == 1'b0) ? config_net[31:0] : config_net[63:32];

    // Ack logic
    reg wbs_ack_o_reg;
    always @(posedge wb_clk_i) begin
        if (wb_rst_i) wbs_ack_o_reg <= 1'b0;
        else wbs_ack_o_reg <= (wbs_cyc_i && wbs_stb_i) && !wbs_ack_o_reg;
    end
    assign wbs_ack_o = wbs_ack_o_reg;

endmodule

