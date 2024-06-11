#!/bin/bash
for ((i=3085997; i<=3086005; i++)); do
  echo "Processing SRR${i}"  # Debugging output
  scp wxueyao@longleaf.unc.edu:/users/w/x/wxueyao/Calabrese_Lab/Alignments/SRR${i}/Kallisto_alignments/SRR${i}_abundance.tsv /Users/sherrywang/Desktop/Research/Calabrese/RNAseq_data/
done
