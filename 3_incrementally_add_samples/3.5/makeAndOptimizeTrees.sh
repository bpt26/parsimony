for i in {1..50}
  do
    /usr/bin/time -o ${i}.usher.time -f "%E %M" usher -v ../CUMULATIVE_VCFs/${i}_samples.vcf -t empty.nwk -o ${i}_samples.pb -T 15
    /usr/bin/time -o ${i}.mo.time -f "%E %M" matOptimize -i ${i}_samples.pb -v ../CUMULATIVE_VCFs/${i}_samples.vcf -o ${i}_samples.opt.pb -T 15
    matUtils summary -i ${i}_samples.pb
    matUtils summary -i ${i}_samples.opt.pb
done;
