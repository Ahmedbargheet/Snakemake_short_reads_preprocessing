# Preprocessing steps for metagenomics reads
This is a Snakemake workflow to: 
1. Check the metagenomics reads quality using Fastqc.
2. Remove low-quality bases and adapters using trimmomatic
3. Double-check the metagenomics reads quality upon trimming using Fastqc.
4. Remove human DNA.

# Installation and requirements
