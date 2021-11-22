for i in {1..21}
  do
    usher -v ../SIM_CUMULATIVE_VCFS/${i}.vcf -t ${i}_samples.iqtree2.denovo.treefile -c -o ${i}_samples.ml.iqtree.opt.condensed.pb -T 1
    matUtils extract -i ${i}_samples.ml.iqtree.opt.condensed.pb -t ${i}_samples.ml.iqtree.opt.condensed.nwk -T 1
done;