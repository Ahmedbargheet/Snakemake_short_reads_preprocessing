# Defining samples and reads
samples = ["sample_name"]
reads = ["1", "2"]

# Rule defining the final output files of the workflow
rule all:
    input:
        expand("result/1.fastqc/{sample}_{read}.fastqc.zip", 
               sample=samples, read=reads),
        expand("result/1.fastqc/{sample}_{read}.fastqc.html", 
               sample=samples, read=reads),
        expand("result/3.fastqc/{sample}_{read}.fastqc.zip", 
               sample=samples, read=reads),
        expand("result/3.fastqc/{sample}_{read}.fastqc.html", 
               sample=samples, read=reads),
        expand("result/4.rm_dna/2.fq/{sample}_cleaned_{read}.fastq.gz", 
               sample=samples, read=reads)

# Rule 1: FastQC on raw reads
rule fastqc_raw:
    input:
        "result/0.data/{sample}_{read}.fastq.gz"
    output:
        "result/1.fastqc/{sample}_{read}.fastqc.zip",
        "result/1.fastqc/{sample}_{read}.fastqc.html"
    shell:
        "fastqc {input} --outdir=result/1.fastqc/"

# Rule 2: Trimmomatic - trimming reads
rule trimmomatic:
    input:
        f1="result/0.data/{sample}_1.fastq.gz",
        f2="result/0.data/{sample}_2.fastq.gz"
    output:
        trim1="result/2.trimmomatic/{sample}_1.trimmed.fastq.gz",
        trim2="result/2.trimmomatic/{sample}_2.trimmed.fastq.gz",
        unpaired1="result/2.trimmomatic/{sample}_1.unpaired.fastq.gz",
        unpaired2="result/2.trimmomatic/{sample}_2.unpaired.fastq.gz"
    resources:
        threads=12
    shell:
        """
        java -jar /trimmomatic/trimmomatic-0.39.jar PE -phred33 -threads {resources.threads} {input.f1} {input.f2} \
        {output.trim1} {output.unpaired1} {output.trim2} {output.unpaired2} \
        ILLUMINACLIP:/trimmomatic/Trimmomatic-0.39/adapters/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
        """

# Rule 3: FastQC on cleaned/trimmed reads (depends on Trimmomatic)
rule fastqc_cleaned:
    input:
        "result/2.trimmomatic/{sample}_{read}.trimmed.fastq.gz"
    output:
        "result/3.fastqc/{sample}_{read}.fastqc.zip",
        "result/3.fastqc/{sample}_{read}.fastqc.html"
    shell:
        "fastqc {input} --outdir=result/3.fastqc/"

# Rule 4: Map reads to human genome and sort BAM (depends on Trimmomatic output)
rule bowtie2_map:
    input:
        f1="result/2.trimmomatic/{sample}_1.trimmed.fastq.gz",
        f2="result/2.trimmomatic/{sample}_2.trimmed.fastq.gz"
    params:
        reference="Human_database/Human" # Download the Human database and index it using Bowtie 2
    output:
        "result/4.rm_dna/1.sort/{sample}_map_sorted.bam"
    resources:
        threads=12
    shell:
        """
        bowtie2 -x {params.reference} -1 {input.f1} -2 {input.f2} --end-to-end --very-sensitive --threads {resources.threads} | \
        samtools view -b -f 12 -F 256 - | \
        samtools sort -o {output}
        """

# Rule 5: Convert BAM to FASTQ (depends on Bowtie2 output)
rule bam_to_fastq:
    input:
        "result/4.rm_dna/1.sort/{sample}_map_sorted.bam"
    output:
        fq1="result/4.rm_dna/2.fq/{sample}_cleaned_1.fastq",
        fq2="result/4.rm_dna/2.fq/{sample}_cleaned_2.fastq"
    shell:
        """
        bedtools bamtofastq -i {input} -fq {output.fq1} -fq2 {output.fq2}
        """

# Rule 6: Zipping FASTQ files (depends on BAM to FASTQ conversion)
rule zipping:
    input:
        fq1="result/4.rm_dna/2.fq/{sample}_cleaned_1.fastq",
        fq2="result/4.rm_dna/2.fq/{sample}_cleaned_2.fastq"
    output:
        gz1="result/4.rm_dna/2.fq/{sample}_cleaned_1.fastq.gz",
        gz2="result/4.rm_dna/2.fq/{sample}_cleaned_2.fastq.gz"
    shell:
        "gzip {input.fq1} {input.fq2}"
