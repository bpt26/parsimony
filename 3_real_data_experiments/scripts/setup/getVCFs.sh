for i in {1..5}
  do
    echo ${i}
    faToVcf AGGREGATE_FASTAS/${i}_with_ref.fasta CUMULATIVE_VCFS/${i}_with_ref.vcf
done;
