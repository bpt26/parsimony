# Compute likelihoods under Jukes Cantor model
for i in {1..12}
  do
    rm *ckp*
    iqtree2 -s ../../input/AGGREGATE_FASTAS/${i}.fasta -te ${i}_samples.iqtree2.denovo.treefile --epsilon 1.0 -m JC --no-opt-gamma-inv -blmin 0.00000000001 -nt 1 -pre JC | grep "BEST SCORE" > ${i}.denovo.likelihood.txt
done;
