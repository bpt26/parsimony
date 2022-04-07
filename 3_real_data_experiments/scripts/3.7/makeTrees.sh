# Create de novo trees with IQ-TREE 2 from the smallest 3 data sets
# Note: these commands were run in parallel on separate machines in our experiments
/usr/bin/time -o iter1.iq.stoch.denovo.time -f "%E %M" iqtree2 -s ../../input/AGGREGATE_FASTAS/WITH_REF/1_with_ref.fasta -m GTR+G --suppress-list-of-sequences -nt 14 -blmin 0.0000000001 -pre iter1.iq.stoch.denovo -seed 2
/usr/bin/time -o iter2.iq.stoch.denovo.time -f "%E %M" iqtree2 -s ../../input/AGGREGATE_FASTAS/WITH_REF/2_with_ref.fasta -m GTR+G --suppress-list-of-sequences -nt 14 -blmin 0.0000000001 -pre iter2.iq.stoch.denovo -seed 2
/usr/bin/time -o iter2.iq.stoch.denovo.time -f "%E %M" iqtree2 -s ../../input/AGGREGATE_FASTAS/WITH_REF/2_with_ref.fasta -m GTR+G --suppress-list-of-sequences -nt 14 -blmin 0.0000000001 -pre iter2.iq.stoch.denovo -seed 2
