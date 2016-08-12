#arrowhead.jl

# include("interface_tape.jl")
# using TapeInterface

using JuMP
using Ipopt

N = 20000
K = 8

# m = Model(solver=TapeSolver(IpoptSolver()))
m = Model(solver=IpoptSolver())

@variable(m, -100<=x[1:N+K]<=100)

@NLobjective(m, Min,  sum{ cos(sum{ x[i+j], j=1:K}) + sum{ (x[i] + x[j])^2, j=1:K} , i=1:N} )

solve(m)

