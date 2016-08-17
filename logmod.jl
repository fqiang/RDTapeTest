#logmod.jl



using JuMP
using Ipopt

M = parse(Int,ARGS[1])
N = parse(Int,ARGS[2])

include(string("log",M,"_",N,"_dat.jl"))

m = Model()

if parse(Int, ARGS[3]) == 1
    include("interface_tape.jl")
    using TapeInterface
    m = Model(solver=TapeSolver(IpoptSolver()))
else 
    m = Model(solver=IpoptSolver())
end

@variable(m, theta[1:N], start=1.0)

#original logrithmic regression
@NLobjective(m, Min, lambda*(sum{ theta[i]^2, i = 1:N}) + sum{ log(1+1/exp(y[i] * sum{ theta[j] * x[i,j]  ,j = 1:N } )), i =1:M})

#log x  -> x^2
#@NLobjective(m, Min, lambda*(sum{ theta[i]^2, i = 1:N}) + sum{ (1+1/exp(y[i] * sum{ theta[j] * x[i,j]  ,j = 1:N } ))^2, i =1:M})

#exp x - > x^2
#@NLobjective(m, Min, lambda*(sum{ theta[i]^2, i = 1:N}) + sum{ log(1+1/(y[i] * sum{ theta[j] * x[i,j]  ,j = 1:N } )^2), i =1:M})

# 1/exp x -> x^2
# @NLobjective(m, Min, lambda*(sum{ theta[i]^2, i = 1:N}) + sum{ log(1+(y[i] * sum{ theta[j] * x[i,j]  ,j = 1:N } )^2 ), i =1:M})

solve(m)
