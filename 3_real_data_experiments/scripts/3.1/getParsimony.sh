for i in {1..11}
  do
    usher -v ../../input/CUMULATIVE_VCFS/${i}_with_ref.vcf -t ${i}_samples.ml.iqtree.opt.nwk -o ${i}_samples.iq.online.pb -T 25  | grep parsimony > $i.parsimony
done;
