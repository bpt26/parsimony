# Online Phylogenetics using Parsimony Supplemental Repository

This repository contains supplemental results, data, and scripts for Thornlow et al., 2022

The subfolders are outlined below.

---

`1_make_starting_tree`: This folder contains scripts to produce a filtered global phylogeny, the "starting tree" in the manuscript. Samples from the starting tree are used in `3_real_data_experiments` to infer trees from real data.


`2_optimize_starting_tree`: The starting tree from the previous folder is optimized with various methods, and the best tree is chosen as the "ground truth" over which to simulate sequences (in folder `4_simulated_data_experiments`)

`3_real_data_experiments`: This folder contains scripts and results of tree inference methods on real SARS-CoV-2 data. Each method is compared by log likelihood.

`4_simulated_data_experiments`: Scripts and results of inference methods on simulated SARS-CoV-2 data. Comparisons between methods are done by computing tree distances to a ground truth phylogeny.

---

## Dependencies

The scripts in this repository use the following programs:
  
  - Python 3
  - The UShER suite (UShER, matOptimize, matUtils)
  - FastTree 2
  - IQ-TREE 2
  - RAxML-NG
  - TreeCmp

Most of the above can be installed with Conda:

```
# Create and activate a new environment
conda create -n parsimony
conda activate usher-env

# Set up channels
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge

# Install packages (versions are those used in our experiments except where stated otherwise)
conda install usher=0.4.8
conda install raxml-ng=1.1.0
conda install iqtree=2.1.3
```

For FastTree 2, install the double-precision executable:
```
wget http://www.microbesonline.org/fasttree/FastTreeDbl
```

For TreeCmp, follow the instructions at https://github.com/TreeCmp/TreeCmp



For more details on the UShER suite, see [the wiki](https://usher-wiki.readthedocs.io/en/latest/index.html).
