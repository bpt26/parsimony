for i in {1..50}
  do
    matUtils extract -i ${i}_samples.opt.pb -t ${i}_samples.nwk -T 15
    matUtils extract -i ${i}_samples.opt.pb -t ${i}_samples.opt.nwk -T 15
    iqtree2 -s /mnt/AGGREGATE_FASTAS/${i}.fasta -te ${i}_samples.opt.nwk --epsilon 1.0 -m JC --no-opt-gamma-inv -blmin 0.00000000001 -nt 4 -pre JC | grep "BEST SCORE" > ${i}.opt.likelihood.txt
    rm *ckp*
    iqtree2 -s /mnt/AGGREGATE_FASTAS/${i}.fasta -te ${i}_samples.nwk --epsilon 1.0 -m JC --no-opt-gamma-inv -blmin 0.00000000001 -nt 4 -pre JC | grep "BEST SCORE" > ${i}.likelihood.txt
    rm *ckp*
done;
