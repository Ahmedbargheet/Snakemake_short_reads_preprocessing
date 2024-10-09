# Preprocessing steps for metagenomics reads
This is a Snakemake workflow to: 
1. Check the metagenomics reads quality using Fastqc.
2. Remove low-quality bases and adapters using trimmomatic
3. Double-check the metagenomics reads quality upon trimming using Fastqc.
4. Remove human DNA.

This workflow was used in 
1. Development of early life gut resistome and mobilome across gestational ages and microbiota-modifying treatments
Authors: Ahmed Bargheet, Claus Klingenberg, Eirin Esaiassen, Erik Hjerde, Jorunn Pauline Cavanagh, Johan Bengtsson-Palme, Veronika Kuchařová Pettersen

2. Dynamics of the Gut Resistome and Mobilome in Early Life: A Meta-Analysis
Authors: Ahmed Bargheet, Hanna Noordzij, Alise Ponsero, Ching Jian, Katri Korpela, Mireia Valles-Colomer, Justine Debelius, Alexander Kurilshikov, Veronika K. Pettersen

# Installation and requirements
