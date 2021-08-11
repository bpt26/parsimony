usher -t empty.nwk -v BATCH_VCFs/1_samples.vcf -C -o 1_samples.0.pb -T 32
bash logOptimizeMatOptimizeParsimony.sh 1_samples
i=2;
for i in {2..75}
  do
      h=$((i-1));
      usher -i ${h}_samples.opt.pb -v BATCH_VCFs/${i}_samples.vcf -C -o ${i}_samples.0.pb -T 32
      bash logOptimizeMatOptimizeParsimony.sh ${i}_samples
done;
