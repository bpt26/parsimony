# Compute likelihoods under Jukes Cantor model
i=1;
for i in {1..50}
  do 
    rm *ckp*
    iqtree2 -s ../../input/AGGREGATE_FASTAS/${i}.fasta -te ${i}_samples.ml.iqtree.opt.nwk --epsilon 1.0 -m JC --no-opt-gamma-inv -blmin 0.00000000001 -nt 4 -pre JC | grep "BEST SCORE" > ${i}.likelihood.txt
done;
