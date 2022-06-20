struct ElementaryCA
    initial_config::AbstractArray
    states::AbstractArray
    function ElementaryCA(initial_config)
        new(initial_config, [initial_config])
    end
end

function run!(automaton::ElementaryCA, rule::Int, steps::Int)
    for i in 1:steps
        step!(automaton, rule)
    end
    return automaton
end

function step!(automaton::ElementaryCA, rule::Int)
    current_state = last(automaton.states)
    updated_state = Bool[]
    bit_rule = bitstring(UInt8(rule))
    n_cells = length(current_state)
    for (i, cell_state) in enumerate(current_state)
        left_neigh = current_state[wrapped_idx(i - 1, n_cells)]
        right_neigh = current_state[wrapped_idx(i + 1, n_cells)]
        triple = [left_neigh, cell_state, right_neigh]
        triple_as_bit = reduce(*, string.(Int.(triple)))
        rule_index = 8 - parse(Int, triple_as_bit, base = 2)
        push!(updated_state, copy(parse(Int, bit_rule[rule_index])))
    end
    push!(automaton.states, updated_state)
    return automaton
end

function wrapped_idx(i, n_cells)
    return (((i) + n_cells - 1) % n_cells) + 1
end

function plot_automaton(automaton::ElementaryCA)
    fig, ax = PyPlot.subplots(1, 1)
    img = ax.imshow(automaton.states, cmap = "gray")
    ax.set_xticks([])
    ax.set_yticks([])
    return true
end
