for i in {1..3}
do
    echo "-->"$i
    ../tqDist-1.0.2/bin/quartet_dist -v "../../GROUND_TRUTH_NEWICKS/STARTING_GROUND_TRUTH_TREE_PRUNED_${i}_COLLAPSED.nwk"  "TREES/iteration_${i}/iter${i}.raxml.denovo.COLLAPSED.nwk"
done