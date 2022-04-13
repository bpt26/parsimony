for i in {1..25}
  do
    usher -v ../../input/CUMULATIVE_VCFS/${i}.vcf -t ${i}_samples.ml.fasttree.gtrg.opt.nwk -c -o ${i}_samples.ml.fasttree.gtrg.opt.pb
    matUtils extract -i ${i}_samples.ml.fasttree.gtrg.opt.pb -R -O -o ${i}_samples.ml.fasttree.gtrg.opt.COLLAPSED.pb -T 15
    matUtils extract -i ${i}_samples.ml.fasttree.gtrg.opt.COLLAPSED.pb -t ${i}_samples.ml.fasttree.gtrg.opt.COLLAPSED.nwk -T 15
done;
