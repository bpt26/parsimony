# comparisons

In this directory, we compare the trees produced in previous steps by various tree congruence metrics, such as Robinson-Foulds distance. We have a few sets of trees that we can compare against each other:

* matOptimized batch trees (1-50) from subdirectory 3
* fasttree optimized batch trees (1-22) from subdirectory 3
* IQ-TREE 2 optimized batch trees (1-13) from subdirectory 3
* unoptimized matUtils trees (1-50) created in this directory by pruning down our starting tree (Section 4.1.1)
* unoptimized UShER trees (1-50) created in this directory using only a .VCF (Section 4.1.2)

^ We will compare each of these through Robinson-Foulds scores in order to determine their congruence to each other.

Additionally, we have various larger trees from subdirectory 2 that we have already compared by parsimony score, and are in the process of simulating data based on the most optimal tree (after_usher_optimized_fasttree_iter6.tree.xz). This will enable comparisons to "ground truth" data, but remains in progress.

## 4.1.1: matOptimized batch trees vs pruned batch trees

```
mkdir MAIN_PB_PRUNED/
bash prunePb.sh
bash convertNwk.sh
mkdir MATOPT_TREECMP_RESULTS/
bash runTreeCmpMatOptimize.sh
python plotMatOptVsPruned.py
tar cfJ matopt_vs_pruned.tar.xz MATOPT_TREECMP_RESULTS/
```
## 4.1.2: matOptimized batch trees vs from-scratch batch trees

```
mkdir SAMPLES_LISTS/
bash getSamplesLists.sh
mkdir CUMULATIVE_VCFs/
bash getCumulativeVCFs.sh
mkdir FROM_SCRATCH_TREES/
bash makeFromScratchTrees.sh
```


