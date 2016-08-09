#logmod.jl

include("interface.jl")
using TapeInterface

using JuMP
using Ipopt

# include("log10000_100_dat.jl")
include("log1000_100_dat.jl")

m = Model(solver=TapeSolver(IpoptSolver()))
# m = Model(solver=IpoptSolver())

@variable(m, theta[1:N])


@NLobjective(m, Min, lambda*(sum{ theta[i]^2, i = 1:N}) + sum{ log(1+1/exp(y[i] * sum{ theta[j] * x[i,j]  ,j = 1:N } )), i =1:M})


solve(m)
