for i in {1..12}
  do
    usher -v /mnt/PARSIMONY_REAL_DATA/CUMULATIVE_VCFS/${i}_samples.vcf -t ${i}_samples.iqtree2.denovo.treefile -o ${i}_samples.iqtree2.denovo.pb
    matUtils summary -i ${i}_samples.iqtree2.denovo.pb
done;
