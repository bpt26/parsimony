# De novo inference with FastTree 2
export OMP_NUM_THREADS=15
for i in {1..50}
  do
    /usr/bin/time -o ${i}.ft.gtrg.time -f "%E %M" FastTreeMP -gtr -gamma -nt -sprlength 1000 -nni 0 -spr 2 -log ${i}.fasttree.gtrg.log -nosupport ../../input/AGGREGATE_FASTAS/${i}.fasta > ${i}_samples.ml.fasttree.gtrg.opt.nwk
done;
unset OMP_NUM_THREADS
