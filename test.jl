using LightGraphs
using DataFrames
using GraphPlot
using Random
using PyPlot

function next_state(bit_rep, rule)
    bit_rule = last(bitstring(rule), 8)
    rule_index = 8 - parse(Int, bit_rep, base=2)
    next_state = bit_rule[rule_index]
    return parse(Int, next_state)
end

function get_bit_rep(iter, idx, g)
    n = copy(neighbors(g, idx))
    push!(n, idx)
    n_with_mod = [(i, i % 10) for i in n]
    sort!(n_with_mod, by=x->x[2])
    n = [i[1] for i in n_with_mod]
    cell_bits = [iter[i] for i in n]
    bit_rep = reduce(*, string.(Int.(cell_bits)))
    return bit_rep
end

function next_iteration(iter, g, rule)
    [next_state(get_bit_rep(iter, i, g), rule) for i in 1:length(iter)]
end


### EXAMPLE 1: RULE 30 ###

# push iterations into this array
automaton = []

# initial configuration
iter = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
push!(automaton, copy(iter))

# construct graph
g = LightGraphs.grid([length(iter), 1], periodic=true)
# gplot(g)

for i in 1:30
    tmp = next_iteration(iter, g, 30)
    push!(automaton, copy(tmp))
    iter = copy(tmp)
end

automaton

imshow(automaton, cmap = "gray")
gcf()


### EXAMPLE 2: RULE 178 ###

# push iterations into this array
automaton = []

# initial configuration
iter = bitrand(50)
push!(automaton, copy(iter))

# construct graph
g = LightGraphs.grid([length(iter), 1], periodic=true)
# gplot(g)

for i in 1:30
    tmp = next_iteration(iter, g, 178)
    push!(automaton, copy(tmp))
    iter = copy(tmp)
end

automaton

imshow(automaton, cmap = "gray")
gcf()


### EXAMPLE 3: RULE 146 ###

# push iterations into this array
automaton = []

# initial configuration
iter = bitrand(50)
push!(automaton, copy(iter))

# construct graph
g = LightGraphs.grid([length(iter), 1], periodic=true)
# gplot(g)

for i in 1:30
    tmp = next_iteration(iter, g, 146)
    push!(automaton, copy(tmp))
    iter = copy(tmp)
end

automaton

imshow(automaton, cmap = "gray")
gcf()