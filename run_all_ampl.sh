let m=1
for n in 2000 4000 8000; do
	echo "ampl logmod.mod - no parameter $m $n"
	echo "include logmod.mod; include log${m}_${n}.dat;" | ampl
	echo "--------------------------------------------"	
done
echo "--------------------------------------------" 
echo "--------------------------------------------" 
echo "--------------------------------------------" 
let m=2
for n in 2000 4000 8000; do
    echo "ampl logmod.mod - no parameter $m $n"
    echo "include logmod.mod; include log${m}_${n}.dat;" | ampl
    echo "--------------------------------------------" 
done
