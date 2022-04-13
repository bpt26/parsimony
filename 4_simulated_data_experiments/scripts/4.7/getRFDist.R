library(ape)

dist.topo(unroot(read.tree("../../input/GROUND_TRUTH_NEWICKS/STARTING_GROUND_TRUTH_TREE_PRUNED_1_COLLAPSED.nwk")), unroot(read.tree("TREES/iteration_1/iter1.iq.stoch.denovo.COLLAPSED.nwk")))
dist.topo(unroot(read.tree("../../input/GROUND_TRUTH_NEWICKS/STARTING_GROUND_TRUTH_TREE_PRUNED_2_COLLAPSED.nwk")), unroot(read.tree("TREES/iteration_2/iter2.iq.stoch.denovo.COLLAPSED.nwk")))
dist.topo(unroot(read.tree("../../input/GROUND_TRUTH_NEWICKS/STARTING_GROUND_TRUTH_TREE_PRUNED_3_COLLAPSED.nwk")), unroot(read.tree("TREES/iteration_3/iter3.iq.stoch.denovo.COLLAPSED.nwk")))