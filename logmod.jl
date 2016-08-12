#logmod.jl

# include("interface_tape.jl")
# using TapeInterface

using JuMP
using Ipopt


include("log1000_100_dat.jl")

# m = Model(solver=TapeSolver(IpoptSolver()))
m = Model(solver=IpoptSolver())

@variable(m, theta[1:N], start=1.0)

#original logrithmic regression
#@NLobjective(m, Min, lambda*(sum{ theta[i]^2, i = 1:N}) + sum{ log(1+1/exp(y[i] * sum{ theta[j] * x[i,j]  ,j = 1:N } )), i =1:M})

#log x  -> x^2
#@NLobjective(m, Min, lambda*(sum{ theta[i]^2, i = 1:N}) + sum{ (1+1/exp(y[i] * sum{ theta[j] * x[i,j]  ,j = 1:N } ))^2, i =1:M})

#exp x - > x^2
@NLobjective(m, Min, lambda*(sum{ theta[i]^2, i = 1:N}) + sum{ log(1+1/(y[i] * sum{ theta[j] * x[i,j]  ,j = 1:N } )^2), i =1:M})

# 1/exp x -> x^2
# @NLobjective(m, Min, lambda*(sum{ theta[i]^2, i = 1:N}) + sum{ log(1+(y[i] * sum{ theta[j] * x[i,j]  ,j = 1:N } )^2 ), i =1:M})

solve(m)
