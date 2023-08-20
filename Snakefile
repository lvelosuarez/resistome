"""
Author: L. Velo Suarez, lourdes.velosuarez@chu-brest.fr, lourdesvelo@gmail.com
Created: Aout 2022
Last Updated: Aout 2023
Affiliation: CBAM (Centre Brestois Analyse Microbiota), CRHU Brest
Aim: Snakemake workflow to process fasta from assemblies and generate resistome data
Run: snakemake -j3 
Run for dag : snakemake --dag | dot -Tsvg > dag.svg
Latest modification: 
- Add rue bakta
"""
import os
from glob import glob
import pandas as pd 

#### DEFINE samples names
df = pd.read_csv('sampleSheet.tsv', sep='\t', index_col=0)
df['sample'] = df.index.to_series().str.split('_').str[0]
sample_id = list(df['sample'].unique())
i =["fasta"]
########## USED FUNCTIONS ####
def get_fasta(samples):
    ''' return a dict with the path to the raw fastq files'''
    fasta = list(df[df["sample"] == samples]['fasta'])
    return {'fasta': fasta }
###############################
rule all:
    input:
        expand("{sample}/{sample}.fna", sample = sample_id),

rule bakta:
    input: 
        unpack(lambda wildcards: get_fasta(wildcards.sample))
    output: 
        annot = '{sample}/{sample}.fna'
    shell: 
        """
    bakta --db /PUBLIC_DATA/bakta/bakta3.10/db --keep-contig-headers  --meta --prefix {wildcards.sample} -v --output {wildcards.sample} -t 10 -m 500 {input.fasta}
        """
