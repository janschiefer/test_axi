

module std_mux
    import std_selector_pkg::*;
 #(
    parameter  int unsigned  WIDTH        = 1                                     ,
    parameter  type          DATA_TYPE    = logic [WIDTH-1:0]                     ,
    parameter  int unsigned  ENTRIES      = 2                                     ,
    parameter  selector_kind KIND         = std_selector_pkg::selector_kind_BINARY,
    localparam int unsigned  SELECT_WIDTH = calc_select_width(ENTRIES, KIND)  
) (
    input  var logic     [SELECT_WIDTH-1:0] i_select,
    input  var DATA_TYPE [ENTRIES-1:0]      i_data  ,
    output var DATA_TYPE                    o_data  
);
    localparam int unsigned BINARY_SELECT_WIDTH = calc_binary_select_width(ENTRIES);
    localparam int unsigned MAX_DEPTH           = $clog2(ENTRIES);

    function automatic DATA_TYPE binary_mux(
        input var logic     [BINARY_SELECT_WIDTH-1:0] select,
        input var DATA_TYPE [ENTRIES-1:0]             data  
    ) ;
        return data[select];
    endfunction

    function automatic DATA_TYPE vector_mux(
        input var logic     [ENTRIES-1:0] select,
        input var DATA_TYPE [ENTRIES-1:0] data  
    ) ;
        int unsigned               current_n     ;
        logic        [ENTRIES-1:0] current_select;
        DATA_TYPE    [ENTRIES-1:0] current_data  ;
        int unsigned               next_n        ;
        logic        [ENTRIES-1:0] next_select   ;
        DATA_TYPE    [ENTRIES-1:0] next_data     ;

        next_n      = ENTRIES;
        next_select = select;
        next_data   = data;
        for (int unsigned _i = 0; _i < MAX_DEPTH; _i++) begin
            current_n      = next_n;
            current_select = next_select;
            current_data   = next_data;

            next_n = (current_n / 2) + (current_n % 2);
            for (int unsigned j = 0; j < next_n; j++) begin
                logic select_even;
                select_even = current_select[2 * j + 0] || ((j + 1) == next_n && (current_n % 2) == 1);
                if (select_even) begin
                    next_select[j] = current_select[2 * j + 0];
                    next_data[j]   = current_data[2 * j + 0];
                end else begin
                    next_select[j] = current_select[2 * j + 1];
                    next_data[j]   = current_data[2 * j + 1];
                end
            end
        end

        return next_data[0];
    endfunction

    function automatic DATA_TYPE onehot_mux(
        input var logic     [ENTRIES-1:0] select,
        input var DATA_TYPE [ENTRIES-1:0] data  
    ) ;
        int unsigned               current_n   ;
        DATA_TYPE    [ENTRIES-1:0] current_data;
        int unsigned               next_n      ;
        DATA_TYPE    [ENTRIES-1:0] next_data   ;

        next_n = ENTRIES;
        for (int unsigned i = 0; i < ENTRIES; i++) begin
            next_data[i] = {{$bits(DATA_TYPE){select[i]}}} & data[i];
        end

        for (int unsigned _i = 0; _i < MAX_DEPTH; _i++) begin
            current_n    = next_n;
            current_data = next_data;

            next_n = (current_n / 2) + (current_n % 2);
            for (int unsigned j = 0; j < current_n; j++) begin
                if ((j + 1) == next_n && ((current_n % 2) == 1)) begin
                    next_data[j] = current_data[2 * j + 0];
                end else begin
                    next_data[j] = current_data[2 * j + 0] | current_data[2 * j + 1];
                end
            end
        end

        return next_data[0];
    endfunction

    if (ENTRIES <= 1) begin :g_mux
        always_comb o_data = i_data[0];
    end else if (KIND == std_selector_pkg::selector_kind_BINARY) begin :g_mux
        always_comb o_data = binary_mux(i_select, i_data);
    end else if (KIND == std_selector_pkg::selector_kind_VECTOR) begin :g_mux
        always_comb o_data = vector_mux(i_select, i_data);
    end else begin :g_mux
        always_comb o_data = onehot_mux(i_select, i_data);
    end
endmodule
//# sourceMappingURL=mux.sv.map
