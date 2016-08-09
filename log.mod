option presolve 0;
param n;
param m;
set N:={1..n};     
set M:={1..m};
var theta{N};
param lambda;
param y{M};
param x{M,N};

minimize obj: lambda*(sum{i in N} theta[i]^2) + sum{i in M}log(1+1/exp(y[i]*(sum{j in N}theta[j]*x[i,j]) )); 


