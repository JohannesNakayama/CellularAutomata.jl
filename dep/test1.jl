include("src/CellularAutomata.jl")


### EXAMPLE 1: RULE 178 ###

# push iterations into this array
automaton = []

# initial configuration
iter = bitrand(100)
push!(automaton, copy(iter))

# construct graph
g = LightGraphs.grid([length(iter), 1], periodic=true)

# run and display automaton
for i in 1:100
    global iter
    tmp = next_iteration(iter, g, 178)
    push!(automaton, copy(tmp))
    iter = copy(tmp)
end
imshow(automaton, cmap = "gray")
gcf()


### EXAMPLE 2: RULE 146 ###

# push iterations into this array
automaton = []

# initial configuration
iter = bitrand(100)
push!(automaton, copy(iter))

# construct graph
g = LightGraphs.grid([length(iter), 1], periodic=true)

# run and display automaton
for i in 1:100
    global iter
    tmp = next_iteration(iter, g, 146)
    push!(automaton, copy(tmp))
    iter = copy(tmp)
end
imshow(automaton, cmap = "gray")
gcf()


### EXAMPLE 3: RULE 30 ###

# push iterations into this array
automaton = []

# initial configuration
iter = vcat(zeros(Int, 200), [1], zeros(Int, 200))
push!(automaton, copy(iter))

# construct graph
g = LightGraphs.grid([length(iter), 1], periodic=true)

# run and display automaton
for i in 1:200
    global iter
    tmp = next_iteration(iter, g, 30)
    push!(automaton, copy(tmp))
    iter = copy(tmp)
end
fig = figure(figsize=(10, 5))
imshow(automaton, cmap = :gray)
PyPlot.axis("off")
gcf()
savefig(joinpath("media", "rule30.png"))







### EXAMPLE 4: RULE 30 ###

# push iterations into this array
automaton = []

# initial configuration
iter = vcat(zeros(Int, 100), ones(Int, 1), zeros(Int, 100))
push!(automaton, copy(iter))

# construct graph
g = LightGraphs.grid([length(iter), 1], periodic=true)

# run and display automaton
for i in 1:100
    global iter
    tmp = next_iteration(iter, g, 30)
    push!(automaton, copy(tmp))
    iter = copy(tmp)
end
imshow(automaton, cmap = "gray")
gcf()
