.DEFAULT_GOAL = music

st-lawrence-lowlands.csv: get_samples.r samples.*
	Rscript get_samples.r

sll_score.csv: st-lawrence-lowlands.csv assign_instruments.jl
	julia assign_instruments.jl

music: sll_score.csv ambient_track.rb
	cat ambient_track.rb | sonic_pi

stop:
	sonic_pi stop

