for i in {1..24}
do
    echo "-->"$i
    /usr/bin/time -o $1.qdist.time -f "%E %M"/usr/bin/time ../../testing/qdist/qdist  "../../GROUND_TRUTH_NEWICKS/STARTING_GROUND_TRUTH_TREE_PRUNED_${i}_COLLAPSED.nwk"  "TREES/${i}_samples.ml.fasttree.gtrg.opt.COLLAPSED.nwk"
done
