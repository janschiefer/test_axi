

module std_demux
    import std_selector_pkg::*;
 #(
    parameter int unsigned  WIDTH        = 1                                     ,
    parameter type          DATA_TYPE    = logic [WIDTH-1:0]                     ,
    parameter int unsigned  DEFUALT_DATA = DATA_TYPE'(0                         ),
    parameter int unsigned  ENTRIES      = 2                                     ,
    parameter selector_kind KIND         = std_selector_pkg::selector_kind_BINARY,
    parameter int unsigned  SELECT_WIDTH = calc_select_width(ENTRIES, KIND)  
) (
    input  var logic     [SELECT_WIDTH-1:0] i_select,
    input  var DATA_TYPE                    i_data  ,
    output var DATA_TYPE [ENTRIES-1:0]      o_data  
);
    if (KIND == std_selector_pkg::selector_kind_BINARY) begin :g_demux
        always_comb begin
            for (int unsigned i = 0; i < ENTRIES; i++) begin
                o_data[i] = ((i_select == SELECT_WIDTH'(i)) ? ( i_data ) : ( DEFUALT_DATA ));
            end
        end
    end else begin :g_demux
        always_comb begin
            for (int unsigned i = 0; i < ENTRIES; i++) begin
                o_data[i] = ((i_select[i]) ? ( i_data ) : ( DEFUALT_DATA ));
            end
        end
    end
endmodule
//# sourceMappingURL=demux.sv.map
