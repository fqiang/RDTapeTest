option presolve 0;
param n;
param m;
set N:={1..n};     
set M:={1..m};
var theta{N} := 1.0;
param lambda;
param y{M};
param x{M,N};

#original lgorithmic regression
minimize obj: lambda*(sum{i in N} theta[i]^2) + sum{i in M}log(1+1/exp(y[i]*(sum{j in N}theta[j]*x[i,j]) )); 

#logx->x^2
#minimize obj: lambda*(sum{i in N} theta[i]^2) + sum{i in M}(1+1/exp(y[i]*(sum{j in N}theta[j]*x[i,j]) ))^2 ; 

#exp x - > x^2
#minimize obj: lambda*(sum{i in N} theta[i]^2) + sum{i in M}log(1+1/(y[i]*(sum{j in N}theta[j]*x[i,j]) )^2 ); 

# 1/exp x -> x^2
#minimize obj: lambda*(sum{i in N} theta[i]^2) + sum{i in M}log(1+(y[i]*(sum{j in N}theta[j]*x[i,j]) )^2 ); 

