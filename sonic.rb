require 'csv'

score = CSV.read("/Users/jake/Research Projects/ecological-composition/sll_score.csv", headers: true)

block_length = 30

puts score["sample"].max

loop do # Between blocks
  
  loop do # Each block
    
    in_thread do
      
      sleep (score[0]["delay"].to_r * block_length)
      sample score[0]["instrument"], rate: score[0]["speed"]
      
    end
    
  end
  
  sleep block_length # Sleep until time for next block
  
end

