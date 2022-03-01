for i in {1..10}
  do
    rm *ckp*
    /usr/bin/time -o ${i}.denovo.iq.time -f "%E %M" iqtree2 -s /mnt/SIM_USHER/IQ/${i}.fasta --suppress-list-of-sequences -nt 15 -blmin .000000000001 -pre ${i}_samples.iqtree2.denovo
done;
