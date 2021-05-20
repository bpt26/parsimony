cat temp.iqtree.fasta ../BATCH_FASTAS/KEEP/$1.fasta > use.iqtree.fasta
iqtree2 -s use.iqtree.fasta -t $1.ml.iqtree.0.nwk -n 0 -m GTR+G --suppress-list-of-sequences -nt 40 -blmin 0.000000001 -pre $1.iqtree2
mv use.iqtree.fasta temp.iqtree.fasta
mv $1.iqtree2.treefile $1.ml.iqtree.opt.nwk

