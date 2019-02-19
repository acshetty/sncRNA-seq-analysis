import os
import pandas as pd
from snakemake.utils import validate, min_version

##### set minimum snakemake version #####
min_version("3.2")

##### load config and sample sheets #####
configfile: "config.yaml"
validate(config, schema="schemas/config.schema.yaml")

samples = pd.read_table(config["samples"]).set_index("sample", drop=False)
validate(samples, schema="schemas/samples.schema.yaml")

units = pd.read_table(config["units"], dtype=str).set_index(["sample", "unit"], drop=False)
units.index = units.index.set_levels([i.astype(str) for i in units.index.levels])  # enforce str in index
validate(units, schema="schemas/units.schema.yaml")

RNATYPES = ["genome","ncRNA","rRNA","tRNA","miRNA","piRNA","Rfam"]

##### target rules #####
rule all:
	input:
		expand("config["outdir"])/counts/{SID}/{SID}.{RType}.count.txt", SID={samples.sample}, RType=RNATYPES), 
		#expand("config["outdir"])/count_matrices/{RType}.count.txt", RType=RNATYPES)

##### load rules #####
include: "rules/common.smk"
include: "rules/index_ref.smk"
#include: "rules/trim_fq.smk"
#include: "rules/align_reads.smk"
#include: "rules/htseq_count.smk"
#include: "rules/samtools_count.smk"
#include: "rules/other.smk"
