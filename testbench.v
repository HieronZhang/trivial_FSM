
`timescale 1ns / 1ns
module testbench();
  parameter half_clk_cycle = 1;
  reg clk_p;
  reg reset;
  reg start;
  wire [4:0] out;
  wire ready;
  wire correct;

  main UUT (reset, start, clk_p, out, ready);

  initial
  begin
    clk_p = 0;
    reset = 0;
    #10;
    reset = 1;
    #10;
    reset = 0;
    start = 1;
  end

  always #2.5 clk_p = ~clk_p;


  integer cycles;
  initial cycles = 0;
  always @(posedge clk_p) begin
    cycles = cycles + 1;
  end

  integer f1;
  integer f2;
  always @(posedge ready) begin
    f1 = $fopen("result.txt", "w");
    f2 = $fopen("cycles.txt", "w");
    #1  $fwrite(f1, "%1d\n", correct);
        $fwrite(f2, "%d\n", cycles);
    #1  $fclose(f1);
        $fclose(f2);
        $stop;
  end
endmodule