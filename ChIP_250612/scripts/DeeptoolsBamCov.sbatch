#!/bin/bash
 
#SBATCH --partition=rhel_short
#SBATCH --container=/config/spack/containers/centos7/container.sif
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=16G
#SBATCH --time=0-8:00:00
#SBATCH --output=logs/DTBamCov%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END
#SBATCH --job-name="DTBamCov"

source /etc/profile.d/modules.sh

module load deeptools/3.5.0

bname=`basename $1 .sort.rmdup.bam`

# RPGC norm
bamCoverage --bam $1 \
  -o bigwigs/${bname}.RPGC.bw \
  --binSize 10 \
  --normalizeUsing RPGC \
  --effectiveGenomeSize 2805636231

