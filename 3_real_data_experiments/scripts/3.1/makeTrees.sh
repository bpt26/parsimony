# Online inference with IQ-TREE 2 (no stochastic search)
# Add the first iteration of samples to an empty tree with UShER
usher -t ../../input/empty.nwk -v ../../input/CUMULATIVE_VCFS/1_with_ref.vcf -o 1_samples.ml.iqtree.0.pb
# Extract the newick tree, resolving polytomies
matUtils extract -i 1_samples.ml.iqtree.0.pb -R -t 1_samples.ml.iqtree.0.nwk
# Optimize the tree with IQ-TREE 2
bash logOptimizeIQTreeML.sh 1
i=2;
for i in {2..50}
  do
    # repeat the above process, adding batches of 
    # ~5k samples to the existing cumulative tree
    # and optimizing with IQ-TREE 2
    h=$((i-1));
    usher -t ${h}_samples.ml.iqtree.opt.nwk -v ../../input/CUMULATIVE_VCFS/${h}_with_ref.vcf -o ${h}_samples.ml.iqtree.opt.pb -T 15
    usher -i ${h}_samples.ml.iqtree.opt.pb -v ../../input/CUMULATIVE_VCFS/${i}_with_ref.vcf -o ${i}_samples.ml.iqtree.0.pb -T 15
    matUtils extract -i ${i}_samples.ml.iqtree.0.pb -R -t ${i}_samples.ml.iqtree.0.nwk -T 15
    bash logOptimizeIQTreeML.sh ${i}
done;
