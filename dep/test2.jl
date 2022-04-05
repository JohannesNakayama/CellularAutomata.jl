include("src/CellularAutomata.jl")
using Random

init_config = bitrand(10)

automaton = CellularAutomata.CellularAutomaton(init_config)

for i in 1:50
    CellularAutomata.step!(automaton, 30)
end

CellularAutomata.plot(automaton)
