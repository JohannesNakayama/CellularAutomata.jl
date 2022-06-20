module CellularAutomata

# Dependencies
using Graphs
using Random
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
export plot_automaton

# BCA
export BlockCA
export run!
export critters
export reverse_critters
export tron
export animate_automaton

# Includes
include("elementary-cellular-automata.jl")
include("block-cellular-automata.jl")

end  # end module
