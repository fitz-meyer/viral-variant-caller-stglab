#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=0:20:00
#SBATCH --qos=normal
#SBATCH --partition=amilan
#SBATCH --job-name=nf-batch
#SBATCH --mail-user=dcking@colostate.edu
#SBATCH --mail-type=END,FAIL,INVALID_DEPEND
#SBATCH --output=%x.%j.log # gives slurm.ID.log

module load miniforge # for conda
conda activate vc-nf  # for nextflow

# make a parseable log if run in batch mode
if [[ ! -t 1 ]]
then
    export NXF_ANSI_LOG=false
fi

# full command
cmd="nextflow run variant_pipeline.nf -resume -with-trace reports/trace.txt -with-report reports/report.html -with-dag reports/flowchart.pdf"
echo $cmd
eval $cmd
