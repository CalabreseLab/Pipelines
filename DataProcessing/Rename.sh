#!/bin/bash

# Replace <startnumber> and <endnumber> with actual values
for i in $(seq 3085918 3086005)
do
    if mv "/users/w/x/wxueyao/Calabrese_Lab/New_Annotation/Alignments/SRR${i}/Kallisto_alignments/abundance.tsv" "/users/w/x/wxueyao/Calabrese_Lab/New_Annotation/Alignments/SRR${i}/Kallisto_alignments/SRR${i}_abundance.tsv"; then
        echo "File SRR${i}_abundance.tsv is ready to be copied."
    else
        echo "Failed to move abundance.tsv for SRR${i}"
    fi
done
