# This script fixes the model and parameters to those chosen by IQ-TREE 2 during each iteration of de novo inference,
# and computes the log likelihood of the IQ-TREE 2 trees under that model

MODEL_STRING_1="GTR{0.2201,0.9970,0.1244,0.1626,3.2321}+F{0.2992,0.1841,0.1949,0.3217}+G4{0.1418}"
MODEL_STRING_2="GTR{0.1851,0.9984,0.1277,0.1599,3.1392}+F{0.2992,0.1841,0.1949,0.3217}+G4{0.2186}"
MODEL_STRING_3="GTR{0.1728,0.9188,0.1089,0.1358,2.9791}+F{0.2992,0.1841,0.1949,0.3217}+G4{0.2438}"
MODEL_STRING_4="GTR{0.1661,0.8901,0.1144,0.1264,2.9743}+F{0.2992,0.1841,0.1949,0.3217}+G4{0.2707}"
MODEL_STRING_5="GTR{0.1630,0.8495,0.1155,0.1277,2.9692}+F{0.2992,0.1841,0.1949,0.3217}+G4{0.2923}"

rm -f *ckp*
iqtree2 -s ../../AGGREGATE_FASTAS/1.fasta -m "$MODEL_STRING_1" --no-opt-gamma-inv -te 1_samples.denovo.opt.nwk.scaled -blmin 0.000000000001 -nt 15 -pre likelihood.1 | grep "BEST SCORE" > 1.gtr.likelihood.txt
iqtree2 -s ../../AGGREGATE_FASTAS/2.fasta -m "$MODEL_STRING_2" --no-opt-gamma-inv -te 2_samples.denovo.opt.nwk.scaled -blmin 0.000000000001 -nt 15 -pre likelihood.2 | grep "BEST SCORE" > 2.gtr.likelihood.txt
iqtree2 -s ../../AGGREGATE_FASTAS/3.fasta -m "$MODEL_STRING_3" --no-opt-gamma-inv -te 3_samples.denovo.opt.nwk.scaled -blmin 0.000000000001 -nt 15 -pre likelihood.3 | grep "BEST SCORE" > 3.gtr.likelihood.txt
iqtree2 -s ../../AGGREGATE_FASTAS/4.fasta -m "$MODEL_STRING_4" --no-opt-gamma-inv -te 4_samples.denovo.opt.nwk.scaled -blmin 0.000000000001 -nt 15 -pre likelihood.4 | grep "BEST SCORE" > 4.gtr.likelihood.txt
iqtree2 -s ../../AGGREGATE_FASTAS/5.fasta -m "$MODEL_STRING_5" --no-opt-gamma-inv -te 5_samples.denovo.opt.nwk.scaled -blmin 0.000000000001 -nt 15 -pre likelihood.5 | grep "BEST SCORE" > 5.gtr.likelihood.txt
