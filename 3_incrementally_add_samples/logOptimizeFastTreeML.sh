export OMP_NUM_THREADS=3
cat temp.fasta ../BATCH_FASTAS/KEEP/$1.fasta > use.fasta
FastTreeMP -nt -sprlength 1000 -nni 0 -spr 2 -log $1.fasttree1.log -nosupport -intree $1.0.nwk use.fasta > $1.ml.fasttree.opt.nwk
unset OMP_NUM_THREADS
mv use.fasta temp.fasta