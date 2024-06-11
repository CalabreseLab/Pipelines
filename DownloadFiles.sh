#!/bin/bash

# Replace the <start number> and <end number>
acc= <your longleaf account>
longleaf_dir= <your longleaf directory for abundance.tsv data>
local_dir= <your local directory for downloading>

for i in $(seq <start number> <end number>); do
  scp $acc: $longleaf_dir/SRR${i}/Kallisto_alignments/SRR${i}_abundance.tsv $local_dir
done
