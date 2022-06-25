#!/bin/bash
#SBATCH --partition=gelifes
#SBATCH --array=1-840
#SBATCH --time=48:00:00
#SBATCH --mem=1000


ml R

replicate_number=$SLURM_ARRAY_TASK_ID

Rscript --vanilla ML_script.R ${replicate_number}
