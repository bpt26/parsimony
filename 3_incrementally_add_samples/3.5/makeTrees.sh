usher -t empty.nwk -v ../CUMULATIVE_VCFS/1_with_ref.vcf -o 1_samples.time.0.pb
/usr/bin/time -o 1.mo.time -f "%E %M" matOptimize -i 1_samples.time.0.pb -v ../CUMULATIVE_VCFS/1_with_ref.vcf -o 1_samples.time.opt.pb -T 15
i=2;
for i in {2..50}
  do
    h=$((i-1));
    usher -i ${h}_samples.time.opt.pb -v ../CUMULATIVE_VCFS/${i}_with_ref.vcf -o ${i}_samples.time.0.pb -T 15
    /usr/bin/time -o ${i}.mo.time -f "%E %M" matOptimize -i ${i}_samples.time.0.pb -v ../CUMULATIVE_VCFS/${i}_with_ref.vcf -o ${i}_samples.time.opt.pb -T 15
done;
