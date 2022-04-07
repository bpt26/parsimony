# Online inference with FastTree 2
# Add the first iteration of samples to an empty tree with UShER
usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/1_with_ref.vcf -o 1_samples.ml.fasttree.gtrg.0.pb
# Extract the newick tree, resolving polytomies
matUtils extract -i 1_samples.ml.fasttree.gtrg.0.pb -R -t 1_samples.ml.fasttree.gtrg.0.nwk
# Optimize the tree with FastTree 2
bash logOptimizeFastTree.sh 1
i=2;
for i in {2..50}
  do
    # repeat the above process, adding batches of 
    # ~5k samples to the existing cumulative tree
    # and optimizing with FastTree 2
    h=$((i-1));
    usher -t ${h}_samples.ml.fasttree.gtrg.opt.nwk -v ../../input/CUMULATIVE_VCFS/${h}_with_ref.vcf -o ${h}_samples.ml.fasttree.gtrg.opt.pb -T 15
    usher -i ${h}_samples.ml.fasttree.gtrg.opt.pb -v ../../input/CUMULATIVE_VCFS/${i}_with_ref.vcf -o ${i}_samples.ml.fasttree.gtrg.0.pb -T 15
    matUtils extract -i ${i}_samples.ml.fasttree.gtrg.0.pb -R -t ${i}_samples.ml.fasttree.gtrg.0.nwk -T 15
    bash logOptimizeFastTree.sh ${i}
done;
