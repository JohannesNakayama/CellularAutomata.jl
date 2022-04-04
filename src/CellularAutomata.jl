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
export ElementaryCellularAutomaton
export run!
export step!
export plot

# BCA
export BlockCellularAutomaton
export run!
export critters
export reverse_critters
export tron
export animate

# Includes
include("elementary-cellular-automata.jl")
include("block-cellular-automata.jl")

end  # end module
