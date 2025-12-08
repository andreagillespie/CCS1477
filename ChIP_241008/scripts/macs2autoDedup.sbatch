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

bname=`basename $1 .sort.bam`

# broad peak calling with full bams, allowing macs to determine maximum allowable reads
srun -n 1 macs2 callpeak -t alignment/$1 alignment/$2 alignment/$3 -c alignment/$4 \
  --broad -g hs -n $5 --keep-dup auto  --outdir macs/broadpeaks_autoDedup -B -q 0.05
  