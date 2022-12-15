for i in {1..3}
do
    echo "-->"$i
    /usr/bin/time -o $1.qdist.time -f "%E %M"/usr/bin/time ../../testing/qdist/qdist  "../../GROUND_TRUTH_NEWICKS/STARTING_GROUND_TRUTH_TREE_PRUNED_${i}_COLLAPSED.nwk"  "TREES/iteration_${i}/iter${i}.iq.stoch.denovo.COLLAPSED.nwk"
done
