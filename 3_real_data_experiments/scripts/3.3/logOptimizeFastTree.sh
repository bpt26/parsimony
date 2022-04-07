export OMP_NUM_THREADS=15
/usr/bin/time -o $1.ft.gtrg.time -f "%E %M" FastTreeMP -gtr -gamma -nt -sprlength 1000 -nni 0 -spr 2 -log $1.fasttree.gtrg.log -nosupport -intree $1_samples.ml.fasttree.gtrg.0.nwk ../../input/AGGREGATE_FASTAS/$1.fasta > $1_samples.ml.fasttree.gtrg.opt.nwk
unset OMP_NUM_THREADS
