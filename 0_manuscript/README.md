# Outline:

## Introduction: 
### 1. Phylogenetics is central to combatting the spread of novel and endemic pathogens. 
+ Pathogen genome sequencing has made phylogenetics central to combatting the pandemic. Examples. 
+ The vast datasets have also shattered typical phylogenetics workflows.
+ The is a need to evaluate new (or in this case old!) approaches for maintaining a real-time up to date comprehensive phylogeny. 

### 2. Imporant differences relative to previous pathogen tracing efforts are caused by the dramatically different pandemic sampling scheme.  
+ During the SARS-CoV-2 pandemic, the vast scale of viral genome sequencing means that samples are often extremely genetically similar or identical. 
+ This is likely to be true in the future for all pathogen genomics efforts going forward. 
+ "State of the art" maximum likelihood approaches are expected to outperform parsimony methods when branch lengths are long. 
+ However, when branches are short, only rarely will two mutations occur on the same branch and the advantages of ML approaches is not clear.  

### 3. Data flows in constantly, this presents an additional major challenge for typical phylgoenetics workflows. 
+ In a typical, *de novo*, phylogenetics workflow, the tree is reinferred starting from scratch periodically. 
+ During a pandemic, data stream in constantly, requiring *de novo* phylogenetics approaches to reinfer the tree very frequently. 
+ As the existing datasets grow, * adding new genome sequenes to the ever-growing phylogeny becomes appealing. 
+ Important, heretofore unresolved, issues surround how to most accurately and efficiently generate and optimize these vast phylogenies. 

### 4. We propose and evaluate a suite of approaches for maintaining a comprehensive globaly phylogeny comprised of XXX SARS-CoV-2 genomes. 
+ ML equivalent to parsimony?
+ Addition + optimizaiton only meanginful choice for vast scale at present. 

## Results and Discussion: 
### 1. We constructed datasets of real and simulated SARS-CoV-2 genomes to faciltiate comparisons of phylogenetics methods into the future.
+ To construct a simulated dataset, we first produced a starting tree by sequential parsimony addition of new samples. 
+ These real dataset is comprised of entirely public sequences, both simulated and real are avaiable from the github page associated with this project. 
+ These standardized datasets will empower future efforts to develop and evaluate phylogenetics approaches by others.

### 2. Comparison of parsimony-based optimization approaches on the starting tree. 
+ Results suggest that iqtree, matOptimize and treeRearrange can improve on a given tree. 
+ Comparisons of parsimony scores, runtimes, memmory usage?

### 3. Maximum likelihood optimizations produce improvements in parsimony score and vice versa. 
+ If true. should confirm and also compute the likelihood of the parsimony optimized final ML tree. Does likelihood improve?
+ Bryan to compute likelihoods for all parsimony optimized trees by holding the topology constant and optimizing brnach lengths in fasttree. 
+ Rob to try additional ML optimization starting from parsimony optimized trees. 

### 4. Simulation of datasets using the finalized optimized tree. 
+ Decide on the tree and ask Nicola for help simulating from it.

### 5. We evaluate strategies for sequence addition and tree optimization over time. 
+ results pending
+ real data
+ simulated data
+ topology compairsons at each step by RF. 
