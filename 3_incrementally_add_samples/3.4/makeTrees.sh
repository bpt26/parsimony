export OMP_NUM_THREADS=15
for i in {1..50}
  do
    /usr/bin/time -o ${i}.ft.time -f "%E %M" FastTreeMP -nt -sprlength 1000 -nni 0 -spr 2 -log ${i}.fasttree.log -nosupport ${i}.fasta > ${i}_samples.ml.fasttree.opt.nwk
    rm *ckp*
    iqtree2 -s ${i}.fasta -te ${i}_samples.ml.fasttree.opt.nwk --epsilon 1.0 -m JC --no-opt-gamma-inv -blmin 0.00000000001 -nt 15 -pre JC | grep "BEST SCORE" > ${i}_samples.ml.fasttree.opt.likelihood.txt
done;
unset OMP_NUM_THREADS
