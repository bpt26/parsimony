for i in {1..25}
  do
    usher -v ../../input/CUMULATIVE_VCFS/${i}.vcf -t ${i}_samples.ml.iqtree.opt.nwk -c -o ${i}_samples.ml.iqtree.opt.pb
    matUtils extract -i ${i}_samples.ml.iqtree.opt.pb -R -O -o ${i}_samples.ml.iqtree.opt.COLLAPSED.pb -T 15
    matUtils extract -i ${i}_samples.ml.iqtree.opt.COLLAPSED.pb -t ${i}_samples.ml.iqtree.opt.COLLAPSED.nwk -T 15
done;
