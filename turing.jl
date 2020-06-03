using Turing, StatsPlots, Random

p_true = 0.5
Ns = 0:100

Random.seed!(12)
data = rand(Bernoulli(p_true), last(Ns))

@model coinflip(y) = begin

  p ~ Beta(1,1)
  N = length(y)
  for n in 1:N
    y[n] ~ Bernoulli(p)
  end
