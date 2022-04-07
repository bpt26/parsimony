for i in {1..12}
  do
    usher -v ../../input/CUMULATIVE_VCFS/${i}_with_ref.vcf -t ${i}_samples.iqtree2.denovo.treefile -o ${i}_samples.iq.denovo.pb -T 15
done;
