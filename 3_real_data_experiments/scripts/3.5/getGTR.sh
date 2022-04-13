i=1;
for i in {1..2}
  do 
    rm *ckp*
    iqtree2 -s ../../input/AGGREGATE_FASTAS/${i}.fasta -te ${i}_samples.time.opt.nwk --epsilon 1.0 -m "GTR{0.14012,0.66091,0.12269,0.09998,2.61404}+F{0.299,0.184,0.196,0.321}+I{0.616}+R5{0.210,0.334,0.219,0.342,0.284,0.344,0.202,1.456,0.085,5.456}" --no-opt-gamma-inv -blmin 0.00000000001 -nt 4 -pre GTR+I+R5_${i} | grep "BEST SCORE" > ${i}.GTR.likelihood.txt
done;
