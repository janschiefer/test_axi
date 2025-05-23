`ifdef __veryl_test_test_axi_test_formal_sec__
    `ifdef __veryl_wavedump_test_axi_test_formal_sec__
        module __veryl_wavedump;
            initial begin
                $dumpfile("test_formal_sec.vcd");
                $dumpvars();
            end
        endmodule
    `endif

module test_linear_sec
#(
    parameter P = 9,
    localparam N = (1 << P) - 1 - P,
    localparam K = N + P
)
(
    input i_clk,
    input  logic [N-1:0] i_word,
    input logic [K-1:0] i_err
);

`ifdef FORMAL
default clocking @(posedge i_clk);
endclocking

default disable iff (1'b0);

as_onehot0: assume property ($onehot0(i_err));

logic [K-1:0] codeword;
logic [K-1:0] perturbed_codeword;
logic [N-1:0] word;
logic corrected;

std_linear_sec_encoder #(.P(P)) u_enc (.*, .o_codeword(codeword));
assign perturbed_codeword = codeword ^ i_err;
std_linear_sec_decoder #(.P(P)) u_dec (
    .i_codeword(perturbed_codeword), .o_word(word), .o_corrected(corrected));

ast_correct: assert property (word == i_word);
ast_error: assert property (corrected == $onehot(i_err));
`else
  initial begin
    $display("Skipping formal verification");
    $finish;
  end
`endif



endmodule
`endif
//# sourceMappingURL=test_linear_sec.sv.map
