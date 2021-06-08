curr=$(matUtils summary -T 32 -i $1.0.pb | grep "Parsimony" | awk '{print $4}');
prev=$((curr + 1));
i=0;
while [ $curr -lt $prev ]
do
  prev=$curr;
  j=$((i+1))
  matOptimize -T 32 -i $1.$i.pb -o $1.$j.pb -s 259200 2>&1 | tee $1.iter_$j.log 
  curr=$(matUtils -T 32 summary -i $1.$j.pb | grep "Parsimony" | awk '{print $4}');
  i=$j
done;
mv $1.$j.pb $1.opt.pb 