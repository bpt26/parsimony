cp 1_samples.0.pb 1_samples.ml.iqtree.0.pb
matUtils extract -i 1_samples.ml.iqtree.0.pb -R -t 1_samples.ml.iqtree.0.nwk
touch temp.iqtree.fasta
bash logOptimizeIQTreeML.sh 1_samples # takes in 1_samples.ml.iqtree.0.nwk, outputs 1_samples.ml.iqtree.opt.nwk
i=2;
for i in {2..75}
  do 
  	h=$((i-1));
	usher -t ${h}_samples.ml.iqtree.opt.nwk -v ../BATCH_VCFs/${h}_samples.vcf -o ${h}_samples.ml.iqtree.opt.pb
	usher -i ${h}_samples.ml.iqtree.opt.pb -v ../BATCH_VCFs/${i}_samples.vcf -o ${i}_samples.ml.iqtree.0.pb
	matUtils extract -i ${i}_samples.ml.iqtree.0.pb -R -t ${i}_samples.ml.iqtree.0.nwk
	bash logOptimizeIQTreeML.sh ${i}_samples # takes in 1_samples.ml.iqtree.0.nwk, outputs 1_samples.ml.iqtree.opt.nwk
done;

