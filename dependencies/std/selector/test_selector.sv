`ifdef __veryl_test_test_axi_test_binary_mux__
    `ifdef __veryl_wavedump_test_axi_test_binary_mux__
        module __veryl_wavedump;
            initial begin
                $dumpfile("test_binary_mux.vcd");
                $dumpvars();
            end
        endmodule
    `endif

module test_binary_mux;
  import std_selector_pkg::*;

  logic [3:0]       select;
  logic [15:0][3:0] input_data;
  logic [3:0]       mux_data;
  logic [15:0][3:0] output_data;

  std_mux #(
    .WIDTH    (4                    ),
    .ENTRIES  (16                   ),
    .KIND     (selector_kind_BINARY )
  ) u_mux (
    .i_select (select     ),
    .i_data   (input_data ),
    .o_data   (mux_data   )
  );

  std_demux #(
    .WIDTH    (4                    ),
    .ENTRIES  (16                   ),
    .KIND     (selector_kind_BINARY )
  ) u_demux (
    .i_select (select       ),
    .i_data   (mux_data     ),
    .o_data   (output_data  )
  );

  initial begin
    for (int i = 0;i < 16;++i) begin
      input_data[i] = i;
    end

    for (int i = 0;i < 16;++i) begin
      select  = i;
      #1;
      for (int j = 0;j < 16;++j) begin
        logic [3:0] expected_data;

        if (j == i) begin
          expected_data = input_data[j];
        end else begin
          expected_data = 0;
        end

        assert (output_data[j] == expected_data)
        else $error("output_data[%0d]: %h expected_data: %h", j, output_data[j], expected_data);
      end
    end

    $finish;
  end
endmodule
`endif

`ifdef __veryl_test_test_axi_test_binary_vector__
    `ifdef __veryl_wavedump_test_axi_test_binary_vector__
        module __veryl_wavedump;
            initial begin
                $dumpfile("test_binary_vector.vcd");
                $dumpvars();
            end
        endmodule
    `endif

module test_vector_mux;
  import std_selector_pkg::*;

  logic [15:0]      select_mux;
  logic [15:0]      select_demux;
  logic [15:0][3:0] input_data;
  logic [3:0]       mux_data;
  logic [15:0][3:0] output_data;

  std_mux #(
    .WIDTH    (4                    ),
    .ENTRIES  (16                   ),
    .KIND     (selector_kind_VECTOR )
  ) u_mux (
    .i_select (select_mux ),
    .i_data   (input_data ),
    .o_data   (mux_data   )
  );

  std_demux #(
    .WIDTH    (4                    ),
    .ENTRIES  (16                   ),
    .KIND     (selector_kind_VECTOR )
  ) u_demux (
    .i_select (select_demux ),
    .i_data   (mux_data     ),
    .o_data   (output_data  )
  );

  initial begin
    for (int i = 0;i < 16;++i) begin
      input_data[i] = i;
    end

    select_mux  = '1;
    for (int i = 0;i < 16;++i) begin
      select_demux    = '0;
      select_demux[i] = '1;

      #1;
      for (int j = 0;j < 16;++j) begin
        logic [3:0] expected_data;

        if (j == i) begin
          expected_data = input_data[j];
        end else begin
          expected_data = 0;
        end

        assert (output_data[j] == expected_data)
        else $error("output_data[%0d]: %h expected_data: %h", j, output_data[j], expected_data);
      end

      select_mux[i] = '0;
    end

    $finish;
  end
endmodule
`endif

`ifdef __veryl_test_test_axi_test_onehot_mux__
    `ifdef __veryl_wavedump_test_axi_test_onehot_mux__
        module __veryl_wavedump;
            initial begin
                $dumpfile("test_onehot_mux.vcd");
                $dumpvars();
            end
        endmodule
    `endif

module test_onehot_mux;
  import std_selector_pkg::*;

  logic [15:0]      select;
  logic [15:0][3:0] input_data;
  logic [3:0]       mux_data;
  logic [15:0][3:0] output_data;

  std_mux #(
    .WIDTH    (4                    ),
    .ENTRIES  (16                   ),
    .KIND     (selector_kind_ONEHOT )
  ) u_mux (
    .i_select (select     ),
    .i_data   (input_data ),
    .o_data   (mux_data   )
  );

  std_demux #(
    .WIDTH    (4                    ),
    .ENTRIES  (16                   ),
    .KIND     (selector_kind_ONEHOT )
  ) u_demux (
    .i_select (select       ),
    .i_data   (mux_data     ),
    .o_data   (output_data  )
  );

  initial begin
    for (int i = 0;i < 16;++i) begin
      input_data[i] = i;
    end

    for (int i = 0;i < 16;++i) begin
      select    = '0;
      select[i] = '1;

      #1;
      for (int j = 0;j < 16;++j) begin
        logic [3:0] expected_data;

        if (j == i) begin
          expected_data = input_data[j];
        end else begin
          expected_data = 0;
        end

        assert (output_data[j] == expected_data)
        else $error("output_data[%0d]: %h expected_data: %h", j, output_data[j], expected_data);
      end
    end

    $finish;
  end
endmodule
`endif
//# sourceMappingURL=test_selector.sv.map
