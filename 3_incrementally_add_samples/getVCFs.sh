for i in {1..50}
  do
    faToVcf AGGREGATE_FASTAS/${i}_with_ref.fasta CUMULATIVE_VCFS/${i}_with_ref.vcf
done;
