using LightGraphs
using GraphPlot
using Plots
using GraphRecipes

g = LightGraphs.grid([20, 1], periodic=true)

n_start = copy(nv(g))
for v in 1:n_start
    add_vertex!(g)
    add_edge!(g, n_start + v, v)
end
n_new = copy(nv(g))
for v in (n_start + 1):n_new
    add_edge!(g, v, ((v + 1) % n_start) + n_start)
end

gplot(g, layout = spring_layout)
graphplot(g, dim=3, markersize=2, curvature_scalar=0.01)