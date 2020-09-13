# Start coding some models
# Lotka-Volterra Equation

using DifferentialEquations
using Plots
function latka_volterra!(du,u,p,t)
    🐰, 🐺 = u
    α, β, γ, δ = p
    du[1] = d🐰 = α*🐰 - β*🐰*🐺
    du[2] = d🐺 = γ*🐰*🐺 - δ*🐺
end

u₀ = [1.0,1.0]

tspan = (0.0, 10.0)
p = [1.5,1.0,3.0,1.0]
prob = ODEProblem(latka_volterra!,u₀,tspan,p)
sol = solve(prob)
plot(sol)

u' = f(u) #
u(0) = u₀
