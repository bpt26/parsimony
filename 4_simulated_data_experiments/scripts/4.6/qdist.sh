for i in {1..50}
do
    echo "-->"$i
    /usr/bin/time -o $1.qdist.time -f "%E %M"/usr/bin/time ../../testing/qdist/qdist  "../../GROUND_TRUTH_NEWICKS/STARTING_GROUND_TRUTH_TREE_PRUNED_${i}_COLLAPSED.nwk"  "TREES/${i}.opt.COLLAPSED.nwk"
done
