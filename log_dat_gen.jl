function write_log_dat_ampl(lambda,M,N)
	theta = Vector{Float64}(N)	
	rand!(theta)
	theta = theta.*7

	f = open(string("log",M,"_",N,".dat"),"w")
	
	write(f, string("# true theta \n"))
	for i=1:N
		write(f,@sprintf("# \t %0.2f \n", theta[i]))
	end

	write(f, "reset data; \n")
	write(f, "data; \n")
	write(f, string("param m := ",M,"; \n"))
	write(f, string("param n := ",N,"; \n"))
	write(f, string("param lambda := ", lambda ,"; \n"))
	write(f, "param \t x: ")
	for i=1:N
		write(f, string("\t ",i))
	end
	write(f, "\t := \n")

	x = randn(M,N)
	x[:,N] = ones(M)
	for i=1:M
		write(f, string("\t",i))
		xx = x[i,:]
		for j=1:N
			write(f, string("\t",xx[j]))
		end
		write(f, "\n");
	end
	write(f, "\t ; \n")
	write(f, "param \t y \t := \n")
	
	p = 1./(1+exp(-x*theta))
	y = Vector{Float64}(M)
	for i=1:M
		write(f, string("\t",i))
		y[i] = generate_bernoulli(p[i])
		write(f, string("\t", y[i], "\n"))
	end
	write(f, "\t ; \n")

	write(f, "option solver ipopt; \n");
	write(f, "solve; \n");

	close(f)
	return theta, x, y
end

function generate_bernoulli(p)
	a = rand()
	if(a<=p)
		return 1.0
	else
		return -1.0
	end
end

function write_log_dat_julia(lambda,t,x,y)
	M, N = size(x)
	f = open(string("log",M,"_",N,"_dat.jl"),"w")
	write(f, string("lambda = ",lambda,"\n"))
	write(f, string("M=",M,"\n"))
	write(f, string("N=",N,"\n"))
	write(f,string("x=Array{Float64,2}(M,N) \n"))
	for i = 1:M
		write(f, string("x[",i,",:]=",x[i,:], "\n"))
	end
	write(f,string("y=",y))
	write(f,"\n")

	close(f)
end

lambda = 1.0
t, x, y = write_log_dat_ampl(lambda, 1000, 100)
write_log_dat_julia(lambda, t , x , y)
# @show t
# @show x
# @show y