export OMP_NUM_THREADS=10
cat temp.fasttree.fasta ../BATCH_FASTAS/KEEP/$1.fasta > use.fasttree.fasta
FastTreeMP -nt -sprlength 1000 -nni 0 -spr 2 -log $1.fasttree.log -nosupport -intree $1.ml.fasttree.0.nwk use.fasttree.fasta > $1.ml.fasttree.opt.nwk
unset OMP_NUM_THREADS
mv use.fasttree.fasta temp.fasttree.fasta
