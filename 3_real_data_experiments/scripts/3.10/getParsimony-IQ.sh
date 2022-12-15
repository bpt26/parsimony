for i in {5..5}
  do
    usher -v ../../CUMULATIVE_VCFS/${i}_with_ref.vcf -t ${i}_samples.iqtree2.denovo.treefile -o ${i}_samples.iq.denovo.pb -T 1 2>&1 >/dev/null | grep parsimony > $i.parsimony
done;
