

using DifferentialEquations
using Plots
function latka_volterra!(du,u,p,t)
    🐰, 🐺 = u
    α, β, γ, δ = p
    du[1] = d🐰 = α*🐰 - β*🐰*🐺
    du[2] = d🐺 = γ*🐰*🐺 - δ*🐺
end


using Turing

Turing.setadbackend(:forwarddiff)

@model function fitlv(data)
    σ ~ InverseGamma(2, 3)
    α ~ truncated(Normal(1.3, 0.5), 0.5, 2.5)
    β ~ truncated(Normal(1.5, 0.5), 0,2)
    γ ~ truncated(Normal(2.7, 0.5),1,4)
    δ ~ truncated(Normal(1.3, 0.5),0,2)

    p = [α, β, γ,δ]
    prob = ODEProblem(latka_volterra!,u₀,(0.0, 10.0),p)
    predicted = solve(prob, Tsit5(),saveat=0.1)

    for i = 1:length(predicted)
        data[:,1] ~ MvNormal(predicted[i], σ)
    end
end

model = fitlv(odedata)
