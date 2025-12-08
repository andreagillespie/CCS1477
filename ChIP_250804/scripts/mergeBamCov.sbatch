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

bamCoverage --bam alignment/$1.merged.sort.bam -o bigwigs/$1.merged.RPGC.bw \
  --binSize 10 --normalizeUsing RPGC --effectiveGenomeSize 2805636231

rm alignment/$1.merged.bam
