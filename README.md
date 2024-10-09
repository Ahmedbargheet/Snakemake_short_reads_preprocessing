# Preprocessing steps for metagenomics reads
### This is a Snakemake workflow to: 
1. Check the quality of metagenomic reads using **FastQC**.
2. Trim low-quality bases and adapter sequences using **Trimmomatic**.
3. Assess the post-trimming quality of reads using **FastQC**.
4. Remove human DNA from the metagenomic dataset.

### This workflow was used in: 
1. Development of early life gut resistome and mobilome across gestational ages and microbiota-modifying treatments <br />
**Authors:** **Ahmed Bargheet**, Claus Klingenberg, Eirin Esaiassen, Erik Hjerde, Jorunn Pauline Cavanagh, Johan Bengtsson-Palme, Veronika Kuchařová Pettersen

3. Dynamics of the Gut Resistome and Mobilome in Early Life: A Meta-Analysis <br />
**Authors:** **Ahmed Bargheet**, Hanna Noordzij, Alise Ponsero, Ching Jian, Katri Korpela, Mireia Valles-Colomer, Justine Debelius, Alexander Kurilshikov, Veronika K. Pettersen

# Installation and requirements
This pipeline requires the use of Snakemake, FastQC v0.11.9, Trimmomatic v0.39, Bowtie 2 v2.4.5, SAMtools v1.17, and BEDTools v2.30.0. <br />
If not previously installed run the following code:<br />

```
git clone https://github.com/Ahmedbargheet/Snakemake_short_reads_preprocessing.git
cd Snakemake_short_reads_preprocessing

## Snakemake installation in a conda environment
conda env create --file envs/env_snakemake.yml

# Alternatively you can create the environment manually:
conda create -n snakemake_env -c bioconda snakemake
conda activate snakemake_env
conda install fastqc=0.11.9 trimmomatic=0.39 bowtie2=2.4.5 samtools=1.17 bedtools=2.30.0
```

**Additionally, the human genome database should be downloaded from [NCBI](https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_000001405.40/)** <br />
**Follow the following steps for downloading and indexing the human genome database**
```
mkdir Human_database
cd Human_database
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/405/GCF_000001405.40_GRCh38.p14/GCF_000001405.40_GRCh38.p14_genomic.fna.gz
gunzip GCF_000001405.40_GRCh38.p14_genomic.fna.gz
bowtie2-build GCF_000001405.40_GRCh38.p14_genomic.fna Human
```

# Overview of the pipeline

# How to run the Snakemake pipeline
In the Snakefile, you will find samples variables. You can change ["sample_name"] to your actual sample name.
The pipeline is designed to work with paired files {sample}_1.fastq.gz and {sample}_2.fastq.gz)

```
# run the pipeline
snakemake --cores 8
