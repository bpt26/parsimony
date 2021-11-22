
usher -t empty.nwk -v ../SIM_CUMULATIVE_VCFS/1.vcf -o 1_samples.0.pb
matOptimize -i 1_samples.0.pb -v ../SIM_CUMULATIVE_VCFS/1.vcf -o 1_samples.opt.pb -T 15
i=2;
for i in {2..50}
  do
    h=$((i-1));
    usher -i ${h}_samples.opt.pb -v ../SIM_CUMULATIVE_VCFS/${i}.vcf -o ${i}_samples.0.pb -T 15
    matOptimize -i ${i}_samples.0.pb -v ../SIM_CUMULATIVE_VCFS/${i}.vcf -o ${i}_samples.opt.pb -T 15
done;
