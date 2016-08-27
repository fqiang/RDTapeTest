#run_logmod.jl.sh

# generating data
# include("log_dat_gen.jl"); m=2; n=2000; for i=1:3; genLogData(m,n); n=2*n; end

opt=$1 #1 - jump, 2 - ep
m=2
for n in 2000 4000 8000; do
    if (( $opt == 1 )); then
        echo "JuMP - logmod.jl - $m $n"
    elif (( $opt == 2 )); then
        echo "Tape - logmod.jl - $m $n"
    fi
    julia logmod.jl $m $n $opt
    echo "====================================== "
done 

