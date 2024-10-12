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
This pipeline requires the use of Snakemake, FastQC v0.11.9, Trimmomatic v=0.39, Bowtie 2 v2.4.5, SAMtools v1.17, and BEDTools v2.30.0. <br />
If not previously installed run the following code:<br />

```
# Clone the repository
git clone https://github.com/Ahmedbargheet/Snakemake_short_reads_preprocessing.git
cd Snakemake_short_reads_preprocessing

## Snakemake installation in a conda environment
conda env create --file envs/env_snakemake.yml

# Alternatively you can create the environment manually:
conda create -n snakemake_env -c bioconda snakemake fastqc=0.11.9 trimmomatic=0.39 bowtie2=2.4.5 samtools=1.17 bedtools=2.30.0
conda activate snakemake_env
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

**Moreover, the Trimmomatic binary file should be downloaded** <br />
**Follow the following steps**
```
mkdir trimmomatic
cd trimmomatic
wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.39.zip
unzip Trimmomatic-0.39.zip
```
# Overview of the pipeline
![Webp net-resizeimage](https://github.com/user-attachments/assets/b61a1266-d17c-45c8-a1f6-b46e90ab99cb)





# How to run the Snakemake pipeline
In the Snakefile, you will find samples variables. You can change ["sample_name"] to your actual sample name.
The pipeline is designed to work with paired files {sample}_1.fastq.gz and {sample}_2.fastq.gz)

```
# run the pipeline
mkdir -p result/1.fastqc/
mkdir -p result/2.trimmomatic/
mkdir -p result/3.fastqc/
mkdir -p result/4.rm_dna/1.sort/
mkdir -p result/4.rm_dna/2.fq/
snakemake --cores 8
```

# Note:
The main workflow is designed to remove adapters from the TruSeq kit.
However, if the sequencing center used adapters from the Nextera kit, you can change this path:
```
/trimmomatic/Trimmomatic-0.39/adapters/TruSeq3-PE.fa
```
**To**
```
/trimmomatic/Trimmomatic-0.39/adapters/NexteraPE-PE.fa
```
