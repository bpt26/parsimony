# De novo inference with UShER + matOptimize
/usr/bin/time -o 1.usher.time -f "%E %M" usher -t empty.nwk -v ../../CUMULATIVE_VCFS/1_with_ref.vcf -o 1_samples.denovo.0.pb
/usr/bin/time -o 1.mo.time -f "%E %M" matOptimize -i 1_samples.denovo.0.pb -v ../../CUMULATIVE_VCFS/1_with_ref.vcf -o 1_samples.denovo.opt.pb
i=2;
for i in {2..5}
  do
    /usr/bin/time -o ${i}.usher.time -f "%E %M" usher -t empty.nwk -v ../../CUMULATIVE_VCFS/${i}_with_ref.vcf -o ${i}_samples.denovo.0.pb -T 15
    /usr/bin/time -o ${i}.mo.time -f "%E %M" matOptimize -i ${i}_samples.denovo.0.pb -v ../../CUMULATIVE_VCFS/${i}_with_ref.vcf -o ${i}_samples.denovo.opt.pb -T 15
done;