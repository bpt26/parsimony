# This script fixes the model and parameters to those chosen by IQ-TREE 2 during each iteration of de novo inference,
# and computes the log likelihood of the IQ-TREE 2 trees under that model

MODEL_STRING_1="GTR{0.2214,1.0171,0.1269,0.1630,3.2358}+F{0.2992,0.1841,0.1949,0.3217}+G4{0.1438}"
MODEL_STRING_2="GTR{0.1872,0.9919,0.1282,0.1624,3.1261}+F{0.2992,0.1841,0.1949,0.3217}+G4{0.2189}"
MODEL_STRING_3="GTR{0.1756,0.9214,0.1102,0.1373,2.9955}+F{0.2992,0.1841,0.1949,0.3217}+G4{0.2437}"
MODEL_STRING_4="GTR{0.1648,0.8809,0.1125,0.1261,2.9708}+F{0.2992,0.1841,0.1949,0.3217}+G4{0.2706}"
MODEL_STRING_5="GTR{0.1621,0.8539,0.1164,0.1273,2.9936}+F{0.2992,0.1841,0.1949,0.3217}+G4{0.2924}"

rm -f *ckp*
iqtree2 -s ../../../AGGREGATE_FASTAS/1.fasta -m "$MODEL_STRING_1" --no-opt-gamma-inv -te 1_samples.denovo.opt.nwk.scaled -blmin 0.000000000001 -nt 15 -pre likelihood.1 | grep "BEST SCORE" > 1.gtr.likelihood.txt
iqtree2 -s ../../../AGGREGATE_FASTAS/2.fasta -m "$MODEL_STRING_2" --no-opt-gamma-inv -te 2_samples.denovo.opt.nwk.scaled -blmin 0.000000000001 -nt 15 -pre likelihood.2 | grep "BEST SCORE" > 2.gtr.likelihood.txt
iqtree2 -s ../../../AGGREGATE_FASTAS/3.fasta -m "$MODEL_STRING_3" --no-opt-gamma-inv -te 3_samples.denovo.opt.nwk.scaled -blmin 0.000000000001 -nt 15 -pre likelihood.3 | grep "BEST SCORE" > 3.gtr.likelihood.txt
iqtree2 -s ../../../AGGREGATE_FASTAS/4.fasta -m "$MODEL_STRING_4" --no-opt-gamma-inv -te 4_samples.denovo.opt.nwk.scaled -blmin 0.000000000001 -nt 15 -pre likelihood.4 | grep "BEST SCORE" > 4.gtr.likelihood.txt
iqtree2 -s ../../../AGGREGATE_FASTAS/5.fasta -m "$MODEL_STRING_5" --no-opt-gamma-inv -te 5_samples.denovo.opt.nwk.scaled -blmin 0.000000000001 -nt 15 -pre likelihood.5 | grep "BEST SCORE" > 5.gtr.likelihood.txt
