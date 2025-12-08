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

# bedgraph compare to get log fold enrichment
srun -n 1 macs2 bdgcmp -t $1 -c $2 --outdir bdgcmp -p 1 -m logFE --o-prefix $3
