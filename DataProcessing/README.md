# STAR-and-Kallisto-instruction
This pipeline utilized STAR and Kallisto alignment on UNC longleaf. For samples with continuous SRR number, it create a loop to submit all the samples automatically.

### 1. Automated directory creation, alignment, and renaming. 
1) Open the Kallisto_Auto.sh file and edit the variables as indicated
2) Upload the file to your workspace on longleaf
3) Submit the file with ./Kallisto_Auto.sh

### 2. Automated downloading of the data 
1) First, set up an SSH key-based authentication to avoid entering passwords every time. Copy the code to your local terminal.

          ssh-keygen -t rsa
        # When asked about passphrase, press enter so that there will be no passphrase and the procedure can be completed automatically.
        # Enter your passcode for longleaf.
          ssh-copy-id <your longleaf account>

3) Then submit the file DownloadFiles.sh to your local terminal.
      
### 3. Merge the tables with R studio by target_id. Retaining only target_id and tpm column.
1) Download and run Merge.Rmd file in R studio. 

