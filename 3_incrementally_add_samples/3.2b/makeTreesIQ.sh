for i in {1..5}
  do
    rm *ckp*
    /usr/bin/time -o ${i}.denovo.iqdefault.time -f "%E %M" iqtree2 -s ../AGGREGATE_FASTAS/${i}_with_ref.fasta -m GTR+G --suppress-list-of-sequences -nt 14 -blmin 0.0000000001 -pre ${i}_samples.iqtree2default.denovo -seed 2
  done;
