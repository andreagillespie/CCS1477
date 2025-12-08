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

bname=`basename $1 _R1.fastq.gz`
ref=/data/reference/dawson_labs/CRISPR/HgChromatin_and_TF_Pool/bowtie2/HgChromatin_and_TF_Pool

trim_galore --fastqc -o trimmed_fastqs cat_fastq/${bname}_R1.fastq.gz
cutadapt -g "CTTGTGGAAAGGACGAAACACCG...GTTTAAGAGCTATGCTGGAAACAG;max_error_rate=0.1" -o trimmed_fastqs/${bname}.trim.fq $1

fastqc -o trimmed_fastqs/ trimmed_fastqs/${bname}.trim.fq

bowtie2 --no-head -p 8 -t -x $ref -U trimmed_fastqs/${bname}.trim.fq -S alignment/${bname}.mapped.sam

#rm trimmed_fastqs/${bname}.trim.fq

# Filtering out mutli-aligning reads with sed \n"
sed '/XS:/d' alignment/${bname}.mapped.sam > alignment/${bname}.unique.sam

#rm alignment/${bname}.mapped.sam

# Extracting column 2 of the file (sgRNA names) with cut \n"
cut -f3 alignment/${bname}.unique.sam > mapped_guides/${bname}.mappedGuides.txt

#rm alignment/${bname}.unique.sam

#Counting occurences of each sgRNA with sort \n"
sort mapped_guides/${bname}.mappedGuides.txt | uniq -c > guide_counts/${bname}.guideCounts.txt

