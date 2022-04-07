# Online inference with FastTree 2
usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/1.vcf -o 1_samples.ml.fasttree.gtrg.0.pb
matUtils extract -i 1_samples.ml.fasttree.gtrg.0.pb -R -t 1_samples.ml.fasttree.gtrg.0.nwk
bash logOptimizeFastTreeGTRG.sh 1
i=2;
for i in {2..50}
  do
    h=$((i-1));
    usher -t ${h}_samples.ml.fasttree.gtrg.opt.nwk -v ../../input/CUMULATIVE_VCFS/${h}.vcf -o ${h}_samples.ml.fasttree.gtrg.opt.pb -T 15
    usher -i ${h}_samples.ml.fasttree.gtrg.opt.pb -v ../../input/CUMULATIVE_VCFS/${i}.vcf -o ${i}_samples.ml.fasttree.gtrg.0.pb -T 15
    matUtils extract -i ${i}_samples.ml.fasttree.gtrg.0.pb -R -t ${i}_samples.ml.fasttree.gtrg.0.nwk -T 15
    bash logOptimizeFastTreeGTRG.sh ${i}
done;
