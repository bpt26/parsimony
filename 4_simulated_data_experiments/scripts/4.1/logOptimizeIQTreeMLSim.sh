/usr/bin/time -o $1.iq.time -f "%E %M" iqtree2 -s ../../input/AGGREGATE_FASTAS/$1.fasta -t $1_samples.ml.iqtree.0.nwk -n 0 -m GTR+G --suppress-list-of-sequences -nt 15 -blmin 0.000000001 -pre $1_samples.iqtree2
mv $1_samples.iqtree2.treefile $1_samples.ml.iqtree.opt.nwk
