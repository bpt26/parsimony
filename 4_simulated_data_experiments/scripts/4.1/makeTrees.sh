# Online inference with IQ-TREE 2
# Add the first iteration of samples to an empty tree with UShER
usher -t ../../input/empty.nwk -v ../../input/CUMULATIVE_VCFS/1.vcf -o 1_samples.ml.iqtree.0.pb
# Extract the newick tree, resolving polytomies
matUtils extract -i 1_samples.ml.iqtree.0.pb -R -t 1_samples.ml.iqtree.0.nwk
# Optimize with IQ-TREE 2
bash logOptimizeIQTreeMLSim.sh 1 # takes in 1_samples.ml.iqtree.0.nwk, outputs 1_samples.ml.iqtree.opt.nwk
i=1;
for i in {2..50}
  do
  # Repeat, adding ~5k samples to the existing
  # cumulative tree
    h=$((i-1));
    usher -t ${h}_samples.ml.iqtree.opt.nwk -v ../../input/CUMULATIVE_VCFS/${h}.vcf -o ${h}_samples.ml.iqtree.opt.pb -T 15
    usher -i ${h}_samples.ml.iqtree.opt.pb -v ../../input/CUMULATIVE_VCFS/${i}.vcf -o ${i}_samples.ml.iqtree.0.pb -T 15
    matUtils extract -i ${i}_samples.ml.iqtree.0.pb -R -t ${i}_samples.ml.iqtree.0.nwk -T 15
    bash logOptimizeIQTreeMLSim.sh ${i}
done;
