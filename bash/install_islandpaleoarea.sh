#!/bin/bash
#SBATCH --time=01:00:00
#SBATCH --partition=regular
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=install_islandpaleoarea
#SBATCH --output=install_islandpaleoarea.log
#SBATCH --mem=2GB

mkdir -p logs
ml R
Rscript -e "remotes::install_github('rsetienne/DAISIE')"
Rscript -e "remotes::install_github('tece-lab/DAISIEutils')"
Rscript -e "remotes::install_github('Neves-P/islandpaleoarea')"
