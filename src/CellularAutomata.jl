module CellularAutomata

# Dependencies
using Graphs
using Random
using PyPlot
using UnicodePlots
using ColorSchemes
using Random
using Chain
using Images
using Sixel
using ImageInTerminal

# ECA
export ElementaryCA
export run!
export step!
export plot

# BCA
export BlockCA
export run!
export critters
export reverse_critters
export tron
export animate

# Includes
include("elementary-cellular-automata.jl")
include("block-cellular-automata.jl")

end  # end module
