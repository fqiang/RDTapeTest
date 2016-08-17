for m in 1 2 4 8; do
	let m=$m*5000 
	echo "tape - $m $1" 
	julia logmod.jl $m $1 1 | tee logmod_tape_${m}_$1.out  
done 
for m in 1 2 4 8; do 
	let m=$m*5000 
	echo "jump - $m $1" 
	julia logmod.jl $m $1 0 | tee logmod_jump_${m}_$1.out
done
