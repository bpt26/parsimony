# Online inference with matOptimize
# Add the first iteration of samples to an empty tree with UShER
usher -t empty.nwk -v ../../input/CUMULATIVE_VCFS/1_with_ref.vcf -o 1_samples.time.0.pb
/usr/bin/time -o 1.mo.time -f "%E %M" matOptimize -i 1_samples.time.0.pb -v ../../input/CUMULATIVE_VCFS/1_with_ref.vcf -o 1_samples.time.opt.pb -T 15
i=2;
for i in {2..50}
  do
    # for each iteration, add a batch of samples
    # with UShER and optimize with matOptimize
    h=$((i-1));
    usher -i ${h}_samples.time.opt.pb -v ../../input/CUMULATIVE_VCFS/${i}_with_ref.vcf -o ${i}_samples.time.0.pb -T 15
    /usr/bin/time -o ${i}.mo.time -f "%E %M" matOptimize -i ${i}_samples.time.0.pb -v ../../input/CUMULATIVE_VCFS/${i}_with_ref.vcf -o ${i}_samples.time.opt.pb -T 15
done;
