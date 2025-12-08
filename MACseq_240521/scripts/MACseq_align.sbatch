#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --job-name=STARsolo
#SBATCH --time=0-04:00:00
#SBATCH --mem=64GB
#SBATCH --mail-user='andrea.gillespie@petermac.org'
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --output=logs/STAR_solo_%j.stdout
#SBATCH --partition=prod_med

module purge
module load star/2.7.5b

REF="/data/reference/dawson_labs/genomes/Hg38/star"
FQDIR="/pipeline/Runs/NextSeq/240521_VH01624_101_AACJ7K3HV/ProjectFolders/Project_Xin-Liu/Sample_OS-7002-Plate/"


STAR --genomeDir $REF \
    --runThreadN 16 \
    --readFilesIn ${FQDIR}/OS-7002-Plate_S2_R2_001.fastq.gz ${FQDIR}/OS-7002-Plate_S2_R1_001.fastq.gz \
    --soloType CB_UMI_Simple \
    --soloCBstart 1 \
    --soloCBlen 10 \
    --soloUMIstart 11 \
    --soloUMIlen 10 \
    --soloBarcodeReadLength 28 \
    --soloCBwhitelist "reference_files/VCFG_metadata_barcode_whitelist.txt" \
    --outSAMattributes NH HI nM AS CR UR CB UB GX GN sS sQ sM \
    --outSAMtype BAM SortedByCoordinate \
    --outFileNamePrefix "alignment/Plate_S2_" \
    --readFilesCommand zcat
