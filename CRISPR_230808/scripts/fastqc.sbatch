#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --partition=prod_short
#SBATCH --mem-per-cpu=4G
#SBATCH --time=0-02:00:00
#SBATCH --output=logs/fastqc%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="fastqc"

module load fastqc/0.11.6

bname=`basename $1 _L001_R1_001.fastq.gz`

# lanes need to be concatenated first
cat $1 $2 > cat_fastq/${bname}_R1.fastq.gz

fastqc -o fastqc/ cat_fastq/${bname}_R1.fastq.gz

# also fastqc individual lanes to check for any issues
fastqc -o lane_fastqc/ $1 $2
