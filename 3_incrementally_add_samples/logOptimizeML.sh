export OMP_NUM_THREADS=3
FastTreeMP -nt -gamma -sprlength 1000 -nni 0 -spr 2 -log $1.fasttree1.log -nosupport -intree $1.0.nwk ../BATCH_FASTAS/$1.fasta > $1.ml.1.nwk
FastTreeMP -nt -gamma -sprlength 1000 -nni 0 -spr 2 -log $1.fasttree2.log -nosupport -intree $1.ml.1.nwk ../BATCH_FASTAS/$1.fasta > $1.ml.opt.nwk
unset OMP_NUM_THREADS