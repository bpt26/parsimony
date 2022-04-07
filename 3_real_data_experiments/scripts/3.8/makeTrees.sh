# First prepare RAxML format binary MSA files
raxml-ng --parse --msa ../../input/AGGREGATE_FASTAS/WITH_REF/${i}_with_ref.fasta --model GTR+G --prefix ${i}
raxml-ng --parse --msa ../../input/AGGREGATE_FASTAS/WITH_REF/${i}_with_ref.fasta --model GTR+G --prefix ${i}
raxml-ng --parse --msa ../../input/AGGREGATE_FASTAS/WITH_REF/${i}_with_ref.fasta --model GTR+G --prefix ${i}

# Create de novo trees with RAxML-NG from the smallest 3 data sets
# Note: these commands were run in parallel on separate machines in our experiments
/usr/bin/time -o iter1.raxml.denovo.time -f "%E %M" raxml-ng -s --msa iter1.raxml.denovo.rba -blmin 0.000000000001 -blopt nr_safe --threads auto{15} --seed 2 --prefix iter1.raxml.denovo
/usr/bin/time -o iter2.raxml.denovo.time -f "%E %M" raxml-ng -s --msa iter2.raxml.denovo.rba -blmin 0.000000000001 -blopt nr_safe --threads auto{15} --seed 2 --prefix iter2.raxml.denovo
/usr/bin/time -o iter2.raxml.denovo.time -f "%E %M" raxml-ng -s --msa iter3.raxml.denovo.rba -blmin 0.000000000001 -blopt nr_safe --threads auto{15} --seed 2 --prefix iter3.raxml.denovo
