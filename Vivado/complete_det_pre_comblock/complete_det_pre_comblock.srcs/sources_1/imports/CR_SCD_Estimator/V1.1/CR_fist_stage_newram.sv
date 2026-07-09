//! @title Parameterizable 2D RAM
//! @author gmarti

module ram2d_col_write_col_read #(
    parameter ROWS = 8, //! Number of ROWS
              COLS = 8, //! Number of COLS
              W    = 16 //! Data Width
) (
    input  logic                                clk,                //! System clock
    input  logic                                wr_port_en,         //! Write Port Enable Signal
    input  logic                                wr_col_en,          //! Write enable signal (port a enable)            
    input  logic         [$clog2(COLS) - 1 : 0] wr_col,             //! RAM Write COL Address               
    input  logic         [W            - 1 : 0] wr_col_data [ROWS], //! Input data               
    input  logic                               rd_col_en,          //! Read COL enable signal (port b enable)            
    input  logic         [$clog2(COLS) - 1 : 0] rd_col,             //! RAM Read COL Address          
    output logic         [W            - 1 : 0] rd_col_data [ROWS]  //! Output data (col format)
);

(* ram_style = "block" *) 
logic [W - 1 : 0] mem [ROWS][COLS]; //! RAM

// port a op (write)
genvar i;
generate
    for (i = 0 ; i < ROWS ; i = i + 1) begin
        always @(posedge clk) begin
            if (wr_port_en) begin
                if (wr_col_en) begin
                    mem[i][wr_col] <= wr_col_data[i];
                end
            end
        end
    end
endgenerate

// port b op (col read)
generate
    for (i = 0 ; i < ROWS ; i = i + 1) begin
        always @(posedge clk) begin
            if (rd_col_en) begin
                rd_col_data[i] <= mem[i][rd_col];
            end
        end
    end
endgenerate

endmodule
