for i in {1..5}
  do
    /usr/bin/time -o ${i}.denovo.raxng.time -f "%E %M" raxml-ng --msa RAXML_MSA/${i}.raxml.rba -blmin 0.000000000001 -blopt nr_safe --threads auto{15} --seed 2 --prefix ${i}
  done;
