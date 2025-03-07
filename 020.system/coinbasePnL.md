
we want to summarizew the data below
we want to create a sort of profit and loss
here's the pattern we want to follow
we had a starting worth of $153,589.10
at that time - market value was $226
we owned ~about 350 at that time, for a unit value of (226 * 350) = $79,100 in bch
in cash: (153589-79100)= $74,489 
we want to start from those seed values, and then calculate the profit and loss
we want to do this for each transaction
if you are able .. list out these as a statement of profit and loss
each line starts with the output of the line before
i'd like to "stack" these.. meaning; we would like our bottom-most value to be the seeds from above, and the top to be the most recent 
in situations where there are overlapping dates; 
 - please order these *upward for sales -- 152, 154, 156, etc
 - please order these *downward for purchases -- 153, 151, 149, etc

we would like to turn this into an on-screen but-still-pretty format 
maybe an ".md" file if you can? with a "click here to copy into clipboard" - even better!

we can ignore the BTC line - it's an anomaly
we can also ignore Name, Type, Fills, % Filled, and Status

 on each outputted line, we want this basic structure 
    * Time Placed          Side     Price    Amount         Total      FxBch          FxCash           FxNet
    * 11/21/23 12:34:56    Buy    $258.88        16     $4,131.72        340      $80,855.04         $???.??
    * 11/21/23 12:34:56    Sell   $248.88         9     $2,234.32        356      $76,723.32         $???.??
    * 11/21/23 02:44:12    Buy    216.36         15     $3,256.14        365      $71,232.86         $???.??
    * 10/21/23 12:34:56    Buy    $255.00       350    $79,100.00        350      $74,489.00     $153,589.10
    
The 3 values marked "Fx__" are the values we want to calculate. 
    FxBch: add BCH for Buy, subtract for Sell
    FxCash: add $$ for Sell, subtract $ when Buy
    FxNet: NetWorth: || Cash on hand | + | FxBch * Price || 
Total will be provided by the data, and will include fees. the seed does not reflect any fees -- that's OK to ignore 

if you are able to provide some feedback on steps i can take to format the data better in subsequent attempts, that would be great -- i hope to repeat this process 
we want to output this for all lines of the following data:
Time Placed
Side
Price
Amount
Total
