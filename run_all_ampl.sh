for i in 1 2 4 8; do
	let i=$i*5000
	echo "ampl $i $1"
	echo "include logmod.mod; include log${i}_$1.dat" | ampl | tee logmod_ampl_${i}_$1.out
done
