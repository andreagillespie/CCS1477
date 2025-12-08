#!/bin/bash

#SBATCH --partition=rhel_short
#SBATCH --container=/config/spack/containers/centos7/container.sif
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=10G
#SBATCH --time=0-2:00:00
#SBATCH --output=../logs/MACS%j.stdout
#SBATCH --mail-user=yih-chih.chan@petermac.org
#SBATCH --mail-type=END
#SBATCH --job-name="MACS"

source /etc/profile.d/modules.sh

module load macs/2.1.1

bname=`basename $1 .sort.rmdup.bam`

# narrow peaks calling with bedgraph outputs
macs2 callpeak -t $1 -c $2 -g hs -n ${bname} --outdir macs/narrowpeaks -B -q 0.05

# broad peak calling with bedgraphs
macs2 callpeak -t $1 -c $2 --broad -g hs -n ${bname} --outdir macs/broadpeaks -B -q 0.05
