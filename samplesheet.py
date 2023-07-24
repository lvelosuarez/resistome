#! /usr/bin/env python
import os
import logging
import pandas as pd
from collections import defaultdict


def get_sample_files(path):
    samples = defaultdict(dict)
    seen = set()
    for dir_name, sub_dirs, files in os.walk(os.path.abspath(path)):
        for fname in files:
            if ".fasta" in fname:
                sample_id = fname.split(".fasta")[0]
                fasta_path = os.path.join(dir_name, fname)
                samples[sample_id]['fasta'] = fasta_path
    samples = pd.DataFrame(samples).T
    samples.index.name = 'sample_id'
    samples.to_csv("sampleSheet.tsv", sep='\t')
    return samples


if __name__ == '__main__':
    import sys
    get_sample_files(".")
