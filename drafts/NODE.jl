using DiffEqFlux, OrdinaryDiffEq, Flux, Optim, Plots
using DifferentialEquations
u0 = Float32[2.0; 0.0]
datasize = 30
tspan = (0.0f0, 1.5f0)
tsteps = range(tspan[1], tspan[2], length = datasize)

function trueODEfunc(du, u, p, t)
    true_A = [-0.1 2.0; -2.0 -0.1]
    du .= ((u.^3)'true_A)'
end

prob_trueode = ODEProblem(trueODEfunc, u0, tspan)
ode_data = Array(solve(prob_trueode, Tsit5(), saveat = tsteps))

using Flux, DiffEqFlux

dudt2 = FastChain((x,p)-> x.^3,
                FastDense(2, 50, tanh),
                FastDense(50,2))
