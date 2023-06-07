`timescale 1ns / 100ps

module Moore_1101_tb;

//input
reg rst_tb, clk_tb;
reg in_tb;      

//output
wire out_tb;

wire  out_gold;    

integer i;
integer seed1;
integer err_count;

Moore_1101_gold inst1(.rst(rst_tb), 
                      .clk(clk_tb), 
                      .in(in_tb), 
                      .out(out_gold));

Moore_1101 inst2(.rst(rst_tb), 
                 .clk(clk_tb), 
                 .in(in_tb), 
                 .out(out_tb));

//assign random input values

initial clk_tb = 1'b0;
always #5 clk_tb = ~clk_tb;

initial
begin
  $fsdbDumpfile("Moore_1101_tb.fsdb");  //your waveform file for nWave
  $fsdbDumpvars;
  $fsdbDumpMDA();
end

initial
begin
  rst_tb = 1'b0;  
  err_count = 0;
  seed1 = 5;
  in_tb = 1'b0; 
  
  #10 rst_tb = 1'b1;
  #10 rst_tb = 1'b0;  

  for(i=0; i<250; i=i+1)
     begin
         in_tb = $random(seed1);
         #10 `ifdef MSG
               $display ($time, " in_tb=%d out_gold=%d out_tb=%d", 
                                  in_tb, out_gold, out_tb);
             `endif

         if (out_tb!==out_gold)
             begin
               $display ($time, " An error occurred.");
               $display ($time, " in_tb=%1d out_gold=%1d out_tb=%1d\n", 
                                  in_tb, out_gold, out_tb);
               err_count=err_count+1;
             end 
      end
      
  #10 rst_tb = 1'b1;
  
  for(i=0; i<5; i=i+1)
     begin
         in_tb = $random(seed1);
         #10 `ifdef MSG
               $display ($time, " in_tb=%d out_gold=%d out_tb=%d", 
                                  in_tb, out_gold, out_tb);
             `endif

         if (out_tb!==out_gold)
             begin
               $display ($time, " An error occurred.");
               $display ($time, " in_tb=%1d out_gold=%1d out_tb=%1d\n", 
                                  in_tb, out_gold, out_tb);
               err_count=err_count+1;
             end 
      end
  
  #10 rst_tb = 1'b0;  

  for(i=0; i<250; i=i+1)
     begin
         in_tb = $random(seed1);
         #10 `ifdef MSG
               $display ($time, " in_tb=%d out_gold=%d out_tb=%d", 
                                  in_tb, out_gold, out_tb);
             `endif

         if (out_tb!==out_gold)
             begin
               $display ($time, " An error occurred.");
               $display ($time, " in_tb=%1d out_gold=%1d out_tb=%1d\n", 
                                  in_tb, out_gold, out_tb);
               err_count=err_count+1;
             end 
      end

  if (err_count !== 0)
      begin
      $display (" There are %3d errors.", err_count);
      $display (" ");
      $display (" ==========================================================");
      $display (" =                                                        =");
      $display (" =                  The test is failed.                   =");
      $display (" =                                                        =");
      $display (" ==========================================================");
      $display (" ");
      end
  else
      begin
      $display (" ");
      $display (" ==========================================================");
      $display (" =                                                        =");
      $display (" =                  The test is successful.               =");
      $display (" =                                                        =");
      $display (" ==========================================================");
      $display (" ");
      end
  
  #10 $stop;
  #10 $finish;       

end

endmodule 
