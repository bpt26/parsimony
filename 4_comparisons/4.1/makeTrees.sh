cp 1_samples.0.pb 1_samples.ml.iqtree.0.pb # use usher scratch tree to start
matUtils extract -i 1_samples.ml.iqtree.0.pb -R -t 1_samples.ml.iqtree.0.nwk
bash logOptimizeIQTreeMLSim.sh 1 # takes in 1_samples.ml.iqtree.0.nwk, outputs 1_samples.ml.iqtree.opt.nwk
i=1;
for i in {2..50}
  do
    h=$((i-1));
    usher -t ${h}_samples.ml.iqtree.opt.nwk -v /mnt/SIM_USHER/SIM_CUMULATIVE_VCFS/${h}.vcf -o ${h}_samples.ml.iqtree.opt.pb -T 15
    usher -i ${h}_samples.ml.iqtree.opt.pb -v /mnt/SIM_USHER/SIM_CUMULATIVE_VCFS/${i}.vcf -o ${i}_samples.ml.iqtree.0.pb -T 15
    matUtils extract -i ${i}_samples.ml.iqtree.0.pb -R -t ${i}_samples.ml.iqtree.0.nwk -T 15
    bash logOptimizeIQTreeMLSim.sh ${i}
done;
