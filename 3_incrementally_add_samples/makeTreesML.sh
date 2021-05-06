matUtils extract -i 1_samples.0.pb -R -t 1_samples.0.nwk
bash logOptimizeML.sh 1_samples
i=2;
for i in {2..75}
  do 
  	h=$((i-1));
  	usher -i ${h}_samples.opt.pb -v ../BATCH_VCFs/${i}_samples.vcf -o ${i}_samples.0.pb
  	matUtils extract -i ${i}_samples.0.pb -R -t ${i}_samples.0.nwk
  	bash logOptimizeML.sh ${i}_samples
done;