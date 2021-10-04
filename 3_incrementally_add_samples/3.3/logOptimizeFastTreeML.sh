export OMP_NUM_THREADS=15
/usr/bin/time -o $1.ft.time -f "%E %M" FastTreeMP -nt -sprlength 1000 -nni 0 -spr 2 -log $1.fasttree.log -nosupport -intree $1_samples.ml.fasttree.0.nwk /mnt/PARSIMONY_REAL_DATA/AGGREGATE_FASTAS/$1.fasta > $1_samples.ml.fasttree.opt.nwk
unset OMP_NUM_THREADS
