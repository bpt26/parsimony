export OMP_NUM_THREADS=15
for i in {1..50}
  do
    /usr/bin/time -o ${i}.ft.gtrg.time -f "%E %M" /mnt/DBL/FastTreeMP -gtr -gamma -nt -sprlength 1000 -nni 0 -spr 2 -log ${i}.denovo.fasttree.gtrg.log -nosupport ../AGGREGATE_FASTAS/${i}.fasta > ${i}_samples.ml.fasttree.gtrg.opt.nwk
done;
unset OMP_NUM_THREADS
