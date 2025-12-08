#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --job-name=genomeBuild
#SBATCH --time=0-12:00:00
#SBATCH --mem=48GB
#SBATCH --mail-user='andrea.gillespie@petermac.org'
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --output=logs/STAR_genomeBuild_%j.stdout
#SBATCH --partition=prod_med

#### Load default modules ####
module purge
module load star/2.7.5b

STAR --runThreadN 4 \
    --runMode genomeGenerate \
    --genomeDir /data/reference/dawson_labs/genomes/Hg38/star \
    --genomeFastaFiles /data/reference/dawson_labs/genomes/Hg38/Homo_sapiens.GRCh38.dna.toplevel.fa \
    --sjdbGTFfile /data/reference/dawson_labs/genomes/Hg38/Homo_sapiens.GRCh38.102.gtf \
    --sjdbOverhang 49 \
    --sjdbGTFtagExonParentTranscript Parent
