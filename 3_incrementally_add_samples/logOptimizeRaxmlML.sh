cat temp.raxml.fasta ../BATCH_FASTAS/KEEP/$1.fasta > use.raxml.fasta
raxml-ng --model GTR+G --tree $1.ml.raxml.0.nwk --msa use.raxml.fasta --blmin 0.000000001  --threads  8
mv use.raxml.fasta temp.raxml.fasta