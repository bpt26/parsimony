for i in {1..26}
  do
    usher -v ../CUMULATIVE_VCFS/${i}.vcf -t ${i}_samples.ml.fasttree.gtrg.opt.nwk -c -o ${i}_samples.ml.fasttree.gtrg.opt.condensed.pb -T 1
    matUtils extract -i ${i}_samples.ml.fasttree.gtrg.opt.condensed.pb -t ${i}_samples.ml.fasttree.gtrg.opt.condensed.nwk -T 1
done;
