usher -t empty.nwk -v ../BATCH_VCFs/1_samples.vcf -o 1_samples.0.pb
bash logOptimize.sh 1_samples
i=2;
for i in {2..75}
  do 
  	h=$((i-1));
  	usher -i ${h}_samples.opt.pb -v ../BATCH_VCFs/${i}_samples.vcf -o ${i}_samples.0.pb
  	bash logOptimize.sh ${i}_samples
done;