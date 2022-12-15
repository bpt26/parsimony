# Compute likelihoods under Jukes Cantor model
i=1;
for i in {1..15}
  do
    echo $i
    ../../pypy3.9-v7.3.10-linux64/bin/pypy3 ../../maple.py --normalizeInputBLen 0.000033 --model JC --inputTree "TREES/${i}_samples.ml.fasttree.gtrg.opt.COLLAPSED.nwk" --input "../../AGGREGATE_FASTAS/${i}.diff" --calculateLKfinalTree --numTopologyImprovements 0 --noFastTopologyInitialSearch --overwrite --output ./
# Compute likelihoods under Jukes Cantor model
#    rm -f *ckp*
#    iqtree2 -s ../../AGGREGATE_FASTAS/${i}.fasta -te ${i}_samples.ml.iqtree.opt.nwk --epsilon 1.0 -m JC --no-opt-gamma-inv -blmin 0.00000000001 -nt 30 -pre JC_$i | grep "BEST SCORE" > ${i}.likelihood.txt
done;