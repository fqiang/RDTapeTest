#random_sparsity.jl

# include("interface_tape.jl")
# using TapeInterface

using JuMP
using Ipopt

N = parse(Int,ARGS[1])
K = parse(Int,ARGS[2])
RandSet= round(Int,readdlm(string("randset",N,"_",K,".txt")))
# @show RandSet

# m = Model(solver=TapeSolver(IpoptSolver()))
m = Model(solver=IpoptSolver())

@variable(m, -100<=x[1:N]<=100)

@NLobjective(m, Min, sum{ (x[i]-1)^2 + prod{x[j], j=RandSet[i,:]}, i=1:N} )

solve(m)

