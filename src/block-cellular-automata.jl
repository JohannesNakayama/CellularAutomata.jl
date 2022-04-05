mutable struct BlockCellularAutomaton
    states::Array{Any}
    function BlockCellularAutomaton(init_state::AbstractMatrix, init_start::Int)
        new([(init_start, init_state)])
    end
end

function run!(automaton::BlockCellularAutomaton, steps::Int, rule::Function)
    for step in 1:steps
        # curr_state = deepcopy(automaton.states[end][2])
        # start = automaton.states[end][1] == 1 ? 2 : 1
        # next_state = zeros(Bool, size(curr_state))
        # Threads.@threads for i in start:2:size(curr_state)[1]
        #     for j in start:2:size(curr_state)[2]
        #         pos1 = [i, j]
        #         pos2 = [i, j+1 <= size(curr_state)[2] ? j+1 : 1]
        #         pos3 = [i+1 <= size(curr_state)[1] ? i+1 : 1, j]
        #         pos4 = [i+1 <= size(curr_state)[1] ? i+1 : 1, j+1 <= size(curr_state)[2] ? j+1 : 1]
        #         block = [
        #             curr_state[pos1...] curr_state[pos2...];
        #             curr_state[pos3...] curr_state[pos4...]
        #         ]
        #         next_state = rule(curr_state, next_state, block, pos1, pos2, pos3, pos4)
        #     end
        # end
        # push!(automaton.states, (copy(start), copy(next_state)))
        step!(automaton, rule)
    end
    return automaton
end

function step!(automaton::BlockCellularAutomaton, rule::Function)
    curr_state = deepcopy(automaton.states[end][2])
    start = automaton.states[end][1] == 1 ? 2 : 1
    next_state = zeros(Bool, size(curr_state))
    Threads.@threads for i in start:2:size(curr_state)[1]
        for j in start:2:size(curr_state)[2]
            pos1 = [i, j]
            pos2 = [i, j+1 <= size(curr_state)[2] ? j+1 : 1]
            pos3 = [i+1 <= size(curr_state)[1] ? i+1 : 1, j]
            pos4 = [i+1 <= size(curr_state)[1] ? i+1 : 1, j+1 <= size(curr_state)[2] ? j+1 : 1]
            block = [
                curr_state[pos1...] curr_state[pos2...];
                curr_state[pos3...] curr_state[pos4...]
            ]
            next_state = rule(curr_state, next_state, block, pos1, pos2, pos3, pos4)
        end
    end
    push!(automaton.states, (copy(start), copy(next_state)))
    return automaton
end

function critters(
    curr_state, next_state, block,
    pos1, pos2, pos3, pos4
)
    block_sum = sum(block)
    if block_sum == 2
        next_state[pos1...] = curr_state[pos1...]
        next_state[pos2...] = curr_state[pos2...]
        next_state[pos3...] = curr_state[pos3...]
        next_state[pos4...] = curr_state[pos4...]
    elseif block_sum in [0, 1, 4]
        next_state[pos1...] = !curr_state[pos1...]
        next_state[pos2...] = !curr_state[pos2...]
        next_state[pos3...] = !curr_state[pos3...]
        next_state[pos4...] = !curr_state[pos4...]
    else
        next_state[pos1...] = !curr_state[pos4...]
        next_state[pos2...] = !curr_state[pos3...]
        next_state[pos3...] = !curr_state[pos2...]
        next_state[pos4...] = !curr_state[pos1...]
    end
    return next_state
end

function reverse_critters(
    curr_state, next_state, block,
    pos1, pos2, pos3, pos4
)
    block_sum = sum(block)
    if block_sum == 2
        next_state[pos1...] = curr_state[pos1...]
        next_state[pos2...] = curr_state[pos2...]
        next_state[pos3...] = curr_state[pos3...]
        next_state[pos4...] = curr_state[pos4...]
    elseif block_sum in [0, 3, 4]
        next_state[pos1...] = !curr_state[pos1...]
        next_state[pos2...] = !curr_state[pos2...]
        next_state[pos3...] = !curr_state[pos3...]
        next_state[pos4...] = !curr_state[pos4...]
    else
        next_state[pos1...] = !curr_state[pos4...]
        next_state[pos2...] = !curr_state[pos3...]
        next_state[pos3...] = !curr_state[pos2...]
        next_state[pos4...] = !curr_state[pos1...]
    end
    return next_state
end

function tron(
    curr_state, next_state, block,
    pos1, pos2, pos3, pos4
)
    block_sum = sum(block)
    if block_sum in [0, 4]
        next_state[pos1...] = !curr_state[pos1...]
        next_state[pos2...] = !curr_state[pos2...]
        next_state[pos3...] = !curr_state[pos3...]
        next_state[pos4...] = !curr_state[pos4...]
    else
        next_state[pos1...] = curr_state[pos1...]
        next_state[pos2...] = curr_state[pos2...]
        next_state[pos3...] = curr_state[pos3...]
        next_state[pos4...] = curr_state[pos4...]
    end
    return next_state
end

function animate(automaton::BlockCellularAutomaton, speed::AbstractFloat)
    println("This function plays a terminal animation of the automaton you provided.")
    println("The implementation is sloppy and ad-hoc, I just wanted something flashy to show in the terminal...")
    println("As the print function is slow, this animation might flicker quite a lot, especially for automata of large size (e.g. (100, 100)).")
    println("If you suffer from epilepsy or are in any way sensitive to such flickering, I'd be careful running this function.")
    println("Do you still wish to proceed? [Please type 'Yes']")
    yes = readline()
    if yes == "Yes"
        for (i, frame) in enumerate(automaton.states)
            if mod(i, 2) == 1
                continue
            end
            Base.run(`clear`)
            imshow(Gray{N0f8}.(Int.(frame[2])))
            sleep(speed)
        end
    else
        println("Aborted animation.")
    end
end
