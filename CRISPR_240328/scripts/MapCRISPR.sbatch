#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --partition=prod_med
#SBATCH --mem-per-cpu=10G
#SBATCH --time=1-0:00:00
#SBATCH --output=logs/CRISPRmap%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END
#SBATCH --job-name="CRISPRmap"

module load cutadapt/2.1
module load bowtie2/2.3.4.1
module load fastqc/0.11.6
module load samtools/1.17

bname=`basename $1 _R1_001.fastq.gz`
ref=/data/reference/dawson_labs/CRISPR/HgChromatin_and_TF_Pool/bowtie2/HgChromatin_and_TF_Pool

fastqc -o fastqc/ $1

cutadapt -g "CTTGTGGAAAGGACGAAACACCG...GTTTAAGAGCTATGCTGGAAACAG;max_error_rate=0.1" -o trimmed_fastqs/${bname}.trim.fq $1

fastqc -o trimmed_fastqs/ trimmed_fastqs/${bname}.trim.fq

bowtie2 --no-head -p 8 -t -x $ref -U trimmed_fastqs/${bname}.trim.fq -S alignment/${bname}.mapped.sam

# Filtering out mutli-aligning reads  
sed '/XS:/d' alignment/${bname}.mapped.sam > alignment/${bname}.unique.sam

rm alignment/${bname}.mapped.sam

# Extracting column 2 of the file (sgRNA names) 
cut -f3 alignment/${bname}.unique.sam > mapped_guides/${bname}.mappedGuides.txt

# Counting occurences of each sgRNA 
sort mapped_guides/${bname}.mappedGuides.txt | uniq -c > guide_counts/${bname}.guideCounts.txt

