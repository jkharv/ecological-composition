# Author: Jake Harvey - jakekharvey@gmail.com

using CSV
using DataFrames
using Random

sll = DataFrame(CSV.File("st-lawrence-lowlands.csv"))

# Assign instruments based on taxonomy. 
# Enter from most general to most specific.
function assign_intstruments(r)
    instrument = missing
    if(r.kingdom == "Fungi")
        instrument = "ASMR"
    end
    if(r.kingdom == "Animalia")
        instrument = "Guitar"
    end
    if(r.kingdom == "Plantae")
        instrument = "Wind"
    end
    if(r.order == "Anura")
        instrument = "Frog"
    end
    if(r.order ∈ ["Anseriformes", "Pelecaniformes"])
        instrument = "Water"
    end
    if(r.order ∈ ["Passeriformes", "Piciformes", "Accipitriformes", "Columbiformes", "Galliformes", "Coraciiformes", 
                  "Apodiformes", "Strigiformes", "Falconiformes"])
        instrument = "Synth"
    end
    return instrument
end


# Create empty cols to assign to later.
sll[!, :delay] .= 0.0
sll[!, :speed] .= 0.0
sll[!, :instrument]  .= ""

# Loop over each row, assigning intruments and parameters for sample playback.
for row in eachrow(sll)
    Random.seed!(hash(row.species))
    row.instrument = assign_intstruments(row) * string(rand(1:3))
    row.delay  = rand()
    row.speed  = rand()
end

select!(sll, [:sample, :instrument, :delay, :speed])

CSV.write("sll_score.csv", sll)
