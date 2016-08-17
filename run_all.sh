let m=$1
let n=500
for i in 1 2 3 4 5; do 
	echo "tape - $m $n" 
	julia logmod.jl $m $n 1 | tee logmod_tape_${m}_${n}.out  
	echo " ------------------------------------------------"
	let n=$n*2
done 
let n=500
for i in 1 2 3 4 5; do 
	echo "jump - $m $n" 
	julia logmod.jl $m $n 0 | tee logmod_jump_${m}_${n}.out
	echo " ------------------------------------------------"
	let n=$n*2
done
