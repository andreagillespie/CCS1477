#!/bin/bash
 
#SBATCH --nodes=1
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

samtools merge -o alignment/$1.Dm.merged.bam alignment/$2 alignment/$3 alignment/$4

samtools sort -o alignment/$1.Dm.merged.sort.bam alignment/$1.Dm.merged.bam

rm alignment/$1.Dm.merged.bam
