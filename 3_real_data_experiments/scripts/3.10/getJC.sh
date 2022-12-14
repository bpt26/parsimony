for i in {1..5}
  do
    rm *ckp*
    iqtree2 -s ../../AGGREGATE_FASTAS/${i}.fasta -te ${i}_samples.denovo.opt.nwk --epsilon 1.0 -m JC --no-opt-gamma-inv -blmin 0.00000000001 -nt 15 -pre JC | grep "BEST SCORE" > ${i}.denovo.jc.likelihood.txt
done;

