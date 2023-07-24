# Resistome analysis
## Set environment
```bash
conda create -y -n bakta3.10 "python=3.10" "mamba>=0.22.1"
conda activate bakta3.10
mamba install -y -c conda-forge -c bioconda bakta snakemake
conda activate bakta3.10
```

## Create the database 
```bash
## Bakta downloader does  not work
wget https://zenodo.org/record/7669534/files/db.tar.gz
tar -xzf db.tar.gz
rm db.tar.gz
amrfinder_update --force_update --database db/amrfinderplus-db/
```

```Ad-note
This is why I used to had a pb avec nextflow funcscan
```
## Run snakefile
```bash
snakemake -j1 --cores 10
```
