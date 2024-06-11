: << 'EOF'
This script automates the processing of SRR files.
It performs the following steps:
1. Loads necessary modules.
2. Creates a main directory for each SRR number.
3. Inside each main directory, creates subdirectories for alignments and reports.
4. Submits SLURM jobs to download fastq files, run STAR alignment, and process BAM files.
5. Logs output and error messages in the reports directory.
EOF

#!/bin/bash

# Load required modules
module load sratoolkit
module load star/2.7.9a
module load samtools

# Array of directory names
newDir=(
    "bam_files"
    "fastq"
    "reports"
)

# Create a variable for your directory.
my_dir="<your directory>"
STAR_ind="<your directory for STAR index file>"
Kall_ind="<your directory for Kallisto transcriptome index file>"

# Replace <startnumber> and <endnumber> with actual values
for i in $(seq <startnumber> <endnumber>)
do
    # Create main directory and subdirectories
    mkdir -p SRR$i/STAR_alignments
    cd SRR$i/STAR_alignments

    # Create directories inside STAR_alignments
    for dir in "${newDir[@]}"
    do
        mkdir -p $dir
        echo "$dir directory created."
    done

    # Move to fastq directory and run fastq-dump
    cd fastq
    fastq_job_id=$(sbatch --parsable --wrap="fastq-dump --split-files SRR$i")

    # Move back to STAR_alignments and run STAR after fastq-dump is complete
    cd ..
    star_job_id=$(sbatch --parsable --dependency=afterok:$fastq_job_id --mem=50g -t 12:00:00 -n 12 -N 1 -o reports/c.out -e reports/c.err --wrap="STAR --runThreadN 12 --genomeDir $STAR_ind --outFileNamePrefix bam_files/SRR$i --readFilesIn fastq/SRR${i}_1.fastq fastq/SRR${i}_2.fastq --outSAMtype BAM SortedByCoordinate")

    # Move to bam_files and run samtools after STAR is complete
    cd bam_files
    samtools_view_job_id=$(sbatch --parsable --dependency=afterok:$star_job_id --wrap="samtools view -b -q 30 SRR${i}Aligned.sortedByCoord.out.bam > SRR${i}Aligned_filteredsq30.out.bam")
    samtools_collate_job_id=$(sbatch --parsable --dependency=afterok:$samtools_view_job_id -o ../reports/samtools.out -e ../reports/samtools.err --wrap="samtools collate -u -O SRR${i}Aligned_filteredsq30.out.bam | samtools fastq -1 SRR${i}Aligned_R1.fq -2 SRR${i}Aligned_R2.fq -0 /dev/null -s /dev/null -n")

    # Move back to STAR_alignments and create Kallisto_alignments after samtools collate is complete
    cd ..
    cd ..
    mkdir -p Kallisto_alignments
    cd Kallisto_alignments

    # Create the kallisto_quant.sh script
    cat << EOF > kallisto_quant.sh
    #!/bin/bash
    #SBATCH -t 24:00:00
    #SBATCH --mem=100G
    #SBATCH -n 8
    
    module load kallisto/0.46.2
    kallisto quant -i $Kall_ind -o $my_dir/SRR$i/Kallisto_alignments --rf-stranded $my_dir/SRR$i/STAR_alignments/bam_files/SRR${i}Aligned_R1.fq $my_dir/SRR$i/STAR_alignments/bam_files/SRR${i}Aligned_R2.fq
    EOF

    # Submit the Kallisto job after the samtools is done
    kallisto_job_id=$(sbatch --parsable --dependency=afterok:$samtools_collate_job_id kallisto_quant.sh)

    # Move back to the main directory
    cd ..
    cd ..
done
