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

module load deeptools/3.5.0

bamCompare -b1 alignment/$1 -b2 alignment/$2 \
  -o bigwigs/${3}_LFC.bw \
  --binSize 10 \
  --scaleFactorsMethod readCount \
  --operation log2 \
  --numberOfProcessors max \
  --effectiveGenomeSize 2805636231
