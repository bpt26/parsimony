# This script fixes the model and parameters to those chosen by RAxML-NG during the first iteration
# and computes the log likelihood of the RAxML tree under that model

MODEL_STRING_1="GTR{0.236070,1.036845,0.122669,0.176486,3.313931}+F{0.297877,0.172738,0.190988,0.338397}+G4{0.162023}"

iqtree2 -s ../../input/AGGREGATE_FASTAS/WITH_REF/1_with_ref.fasta -m "$MODEL_STRING_1" --no-opt-gamma-inv -te trees/iteration_1/iter1.raxml.denovo.bestTree -blmin 0.000000000001 -nt 15 -pre likelihood.raxml.fixedToRAxML.iter1 | grep "BEST SCORE" > iter1.raxml.denovo.fixedToRAxML.likelihood.txt
