for i in {1..50}
  do
    matUtils extract -i STARTING_GROUND_TRUTH_PRUNED/STARTING_GROUND_TRUTH_TREE_PRUNED_${i}.pb -O -o GROUND_TRUTH_NEWICKS/STARTING_GROUND_TRUTH_TREE_PRUNED_${i}_COLLAPSED.pb -T 30
    matUtils extract -i GROUND_TRUTH_NEWICKS/STARTING_GROUND_TRUTH_TREE_PRUNED_${i}_COLLAPSED.pb -t GROUND_TRUTH_NEWICKS/STARTING_GROUND_TRUTH_TREE_PRUNED_${i}_COLLAPSED.nwk
done;
