for i in {1..5}
  do
    raxml-ng --parse --msa ../AGGREGATE_FASTAS/${i}_with_ref.fasta --model GTR+G --prefix ${i}
  done;
