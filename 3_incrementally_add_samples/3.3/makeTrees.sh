cp 1_samples.0.pb 1_samples.ml.fasttree.0.pb
matUtils extract -i 1_samples.ml.fasttree.0.pb -R -t 1_samples.ml.fasttree.0.nwk
bash logOptimizeFastTreeML.sh 1
i=2;
for i in {2..50}
  do
    h=$((i-1));
    usher -t ${h}_samples.ml.fasttree.opt.nwk -v /mnt/PARSIMONY_REAL_DATA/CUMULATIVE_VCFS/${h}_samples.vcf -o ${h}_samples.ml.fasttree.opt.pb -T 15
    usher -i ${h}_samples.ml.fasttree.opt.pb -v /mnt/PARSIMONY_REAL_DATA/CUMULATIVE_VCFS/${i}_samples.vcf -o ${i}_samples.ml.fasttree.0.pb -T 15
    matUtils extract -i ${i}_samples.ml.fasttree.0.pb -R -t ${i}_samples.ml.fasttree.0.nwk -T 15
    bash logOptimizeFastTreeML.sh ${i}
done;
