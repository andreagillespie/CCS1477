#!/bin/bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=10G
#SBATCH --time=0-2:00:00
#SBATCH --output=logs/MACS%j.stdout
#SBATCH --mail-user=andrea.gillespie@petermac.org
#SBATCH --mail-type=END
#SBATCH --job-name="MACS"
#SBATCH --partition=prod_short

module load macs/2.2.7.1

# narrow peaks calling with bedgraph outputs
srun -n 1 macs2 callpeak -t alignment/$1 alignment/$2 alignment/$3 -c alignment/$4 \
  -g hs -n $5 --outdir macs/narrowpeaks -B -q 0.05

# broad peak calling with bedgraphs
srun -n 1 macs2 callpeak -t alignment/$1 alignment/$2 alignment/$3 -c alignment/$4 \
  --broad -g hs -n $5 --outdir macs/broadpeaks -B -q 0.05
