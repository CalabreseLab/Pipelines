#!/bin/bash

# Replace <Start Number> and <End Number> with your own SRR number
# Replace <Your Account> with your account
# Replace <Your Online Path> with your online workplace directory and <Your Local Path> with your local directory.

for ((i=<Start Number>; i<=<End Number>; i++)); do
  echo "Processing SRR${i}"  # Debugging output
  scp <Your Account>:<Your Online Path>/SRR${i}/Kallisto_alignments/SRR${i}_abundance.tsv <Your Local Path>
done
