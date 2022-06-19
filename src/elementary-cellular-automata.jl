mutable struct ElementaryCA
    initial_config::AbstractArray
    states::AbstractArray
    function ElementaryCA(initial_config)
        new(initial_config, [initial_config])
    end
end

function run!(automaton::ElementaryCA, rule::Int, n::Int)
    for i in 1:n
        step!(automaton, rule)
    end
    return automaton
end

function step!(automaton::ElementaryCA, rule::Int)
    g = Graphs.grid([length(automaton.initial_config), 1], periodic = true)
    push!(automaton.states, next_iteration(last(automaton.states), g, rule))
    return automaton
end

function next_iteration(iter, g, rule)
    return [next_state(get_bit_rep(iter, i, g), rule) for i in 1:length(iter)]
end

function next_state(bit_rep, rule)
    bit_rule = last(bitstring(rule), 8)
    rule_index = 8 - parse(Int, bit_rep, base = 2)
    next_state = bit_rule[rule_index]
    return parse(Int, next_state)
end

function get_bit_rep(iter, idx, g)
    n = copy(neighbors(g, idx))
    push!(n, idx)
    n_with_mod = [(i, i % 10) for i in n]
    sort!(n_with_mod, by = x -> x[2])
    n = [i[1] for i in n_with_mod]
    cell_bits = [iter[i] for i in n]
    bit_rep = reduce(*, string.(Int.(cell_bits)))
    return bit_rep
end

function plot(automaton::ElementaryCA)
    PyPlot.imshow(automaton.states, cmap="gray")
end
