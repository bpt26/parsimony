# De novo inference with IQ-TREE 2
for i in {1..50}
  do
    rm *ckp*
    /usr/bin/time -o ${i}.denovo.iq.time -f "%E %M" iqtree2 -s ../../input/AGGREGATE_FASTAS/${i}.fasta -n 0 -m GTR+G --suppress-list-of-sequences -nt 15 -blmin 0.000000001 -pre ${i}_samples.iqtree2.denovo
done;
