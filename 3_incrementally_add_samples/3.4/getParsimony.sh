for i in {1..13}
  do
    usher -v /mnt/REAL_DATA/CUMULATIVE_VCFS/${i}_samples.vcf -t ${i}_samples.ml.fasttree.opt.nwk -o ${i}_samples.ft.denovo.pb -T 15
    matUtils summary -i ${i}_samples.ft.denovo.pb
done;
