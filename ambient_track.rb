require 'csv'

samples = "/Users/jake/Research Projects/ecological-composition/samples/"

ASMR1 = samples + "ASMR1.wav"
ASMR2 = samples + "ASMR2.wav"
ASMR3 = samples + "ASMR3.wav"

Frog1 = samples + "Frog1.wav"
Frog2 = samples + "Frog2.wav"
Frog3 = samples + "Frog3.wav"

Water1 = samples + "Water1.wav"
Water2 = samples + "Water2.wav"
Water3 = samples + "Water3.wav"

Wind1 = samples + "Wind1.wav"
Wind2 = samples + "Wind2.wav"
Wind3 = samples + "Wind3.wav"

Guitar1 = :guit_e_fifths
Guitar2 = :guit_em9
Guitar3 = :guit_e_slide

Synth1 = :glitch_bass_g
Synth2 = :glitch_perc1
Synth3 = :bass_trance_c

score = CSV.read("/Users/jake/Research Projects/ecological-composition/sll_score.csv", headers: true)

score["sample"] = score["sample"].map{|num| num.to_i}
score["delay"] = score["delay"].map{|num| num.to_r}
score["speed"] = score["speed"].map{|num| num.to_r}

block_length = 60

score["sample"].max.times do |i| # Between blocks
  
  score["sample"].count(i).times do |j| # Each block
    
    in_thread do
      
      s = i + j
      sleep (score[s]["delay"].to_r * block_length)
      sample eval(score[s]["instrument"]), rate: score[s]["speed"]
      puts "block " + i.to_s + " sample " + j.to_s
    end
    sleep 0.01
  end
  
  sleep block_length # Sleep until time for next block
end
