let m=$1
let n=500
for i in 1 2 3 4 5; do
	echo "ampl $m $n"
	echo "include logmod.mod; include log${m}_${n}.dat;" | time ampl | tee logmod_ampl_${m}_${n}.out
	echo "--------------------------------------------"	
	let n=$n*2
done
