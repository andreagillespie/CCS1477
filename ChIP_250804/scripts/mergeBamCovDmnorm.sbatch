#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=16G
#SBATCH --time=0-08:00:00
#SBATCH --output=logs/deeptoolsCov%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END,TIME_LIMIT_80
#SBATCH --job-name="bigwigs"
#SBATCH --partition=rhel_short
#SBATCH --container=/config/spack/containers/centos7/container.sif

source /etc/profile.d/modules.sh

module load samtools/1.17
module load deeptools/3.5.0

samtools merge -@ 1 -o alignment/$1.merged.bam alignment/$2 alignment/$3 alignment/$4

samtools sort -@ 1 -o alignment/$1.merged.sort.bam alignment/$1.merged.bam

samtools index -@ 1 alignment/$1.merged.sort.bam

bamCoverage --bam alignment/$1.merged.sort.bam -o bigwigs/$1.merged.Dmnorm.bw \
  --binSize 10 --scaleFactor $5

rm alignment/$1.merged.bam
