for i in {1..12}
  do
    rm *ckp*
    iqtree2 -s /mnt/PARSIMONY_REAL_DATA/AGGREGATE_FASTAS/${i}.fasta -te ${i}_samples.ml.fasttree.opt.nwk --epsilon 1.0 -m JC --no-opt-gamma-inv -blmin 0.00000000001 -nt 1 -pre JC | grep "BEST SCORE" > ${i}.likelihood.txt
done;