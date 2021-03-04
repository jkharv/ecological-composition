require 'csv'

score = CSV.read("/Users/jake/Research Projects/ecological-composition/sll_score.csv", headers: true)

score["sample"] = score["sample"].map{|num| num.to_i}
score["delay"] = score["delay"].map{|num| num.to_r}
score["speed"] = score["speed"].map{|num| num.to_r}

block_length = 30

score["sample"].max.times do |i| # Between blocks
  
  score["sample"].count(i).times do |j| # Each block
    
    in_thread do
      
      s = i + j
      sleep (score[s]["delay"].to_r * block_length)
      sample score[s]["instrument"], rate: score[s]["speed"]
      puts "block " + i.to_s + " sample " + j.to_s
    end
    sleep 0.01
  end
  
  sleep block_length # Sleep until time for next block
end

