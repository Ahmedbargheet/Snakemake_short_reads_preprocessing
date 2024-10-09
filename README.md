# Preprocessing steps for metagenomics reads
### This is a Snakemake workflow to: 
1. Check the quality of metagenomic reads using **FastQC**.
2. Trim low-quality bases and adapter sequences using **Trimmomatic**.
3. Assess the post-trimming quality of reads using **FastQC**.
4. Remove human DNA from the metagenomic dataset.

**This workflow was used in:** 
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
conda env create snakemake_env --file envs/env_snakemake.yml
# Alternatively you can create the environment manually:
conda create -n snakemake_env bioconda::snakemake
conda activate snakemake_env
conda install snakemake
```

