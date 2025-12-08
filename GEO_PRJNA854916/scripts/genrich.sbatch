#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=40G
#SBATCH --time=0-02:00:00
#SBATCH --output=logs/genrich_%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="genrich"
#SBATCH --partition=prod_short

module purge
module load genrich/0.6.0

bname=`basename $1 .namesort.rmdup.bam`

Genrich -t $1 -o genrich/${bname}.narrowPeak -f genrich/${bname}.bdg -j \
  -e chrM -r -v -E /data/reference/dawson_labs/blacklists/GRCh38BlacklistV2.bed
