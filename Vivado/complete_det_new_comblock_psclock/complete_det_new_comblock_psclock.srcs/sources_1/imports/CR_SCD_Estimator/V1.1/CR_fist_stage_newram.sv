//! @title Parameterizable 2D RAM
//! @author gmarti
//
//! Parameterizable 2D RAM storage with data width W, ROWS rows, and COLS columns. Provides two main operations: 
//!
//! - Column Write: Writes an entire column of ROWS data in one clock cycle using unpacked array input.
//! 
//! - Column Read: Reads an entire column of ROWS data, returned as an unpacked array with 1-cycle latency.
//
// Module: ram2d_col_write_multi_read
// Description: 
// Parameterizable 2D RAM with ROWS × COLS organization and data width W. 
// Supports two main operations: column write and column read with 1-cycle latency for reads. 
//
// I/O Signals:
// | Signal        | Dir  | Width / Type                       | Description                                                              |
// |---------------|------|------------------------------------|--------------------------------------------------------------------------|
// | clk           | in   | 1 bit (logic)                      | System clock                                                             |
// | wr_port_en    | in   | 1 bit (logic)                      | Enable signal for write operations                                       |
// | wr_col_en     | in   | 1 bit (logic)                      | Column write enable (port a)                                             |
// | wr_col        | in   | [$clog2(COLS)-1:0]                 | Column address for writing data                                          |
// | wr_col_data   | in   | signed [W-1:0] × ROWS              | Input data array for the specified column                                |
// | rd_col_en     | in   | 1 bit (logic)                      | Column read enable (port b)                                              |
// | rd_col        | in   | [$clog2(COLS)-1:0]                 | Column address to read                                                   |
// | rd_col_data   | out  | signed [W-1:0] × ROWS              | Output data from the selected column                                     |

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
