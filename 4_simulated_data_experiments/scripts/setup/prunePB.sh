for i in {1..50}
do
  matUtils extract -i STARTING_GROUND_TRUTH_TREE.pb -s ../CUMULATIVE_SAMPLES/${i}_samples.txt -o STARTING_GROUND_TRUTH_TREE_PRUNED_${i}.pb -T 30
  matUtils extract -i STARTING_GROUND_TRUTH_TREE_PRUNED_${i}.pb -v SIM_CUMULATIVE_VCFS/${i}.vcf -T 30
done;
