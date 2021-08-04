# comparisons

In this directory, we compare the trees produced in previous steps by various tree congruence metrics, such as Robinson-Foulds distance.

## 4.1.1: matOptimized batch trees vs pruned batch trees

```
mkdir SAMPLES_LISTS/
bash getSamplesLists.sh
mkdir MAIN_PB_PRUNED/
bash prunePb.sh
bash convertNwk.sh
mkdir MATOPT_TREECMP_RESULTS/
bash runTreeCmpMatOptimize.sh
python plotMatOptVsPruned.py
tar cfJ matopt_vs_pruned.tar.xz MATOPT_TREECMP_RESULTS/
```
## 4.1.2: matOptimized batch trees vs from-scratch batch trees


