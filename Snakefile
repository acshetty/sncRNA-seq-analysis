import os, sys
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

RNATYPES = "genome,ncRNA,rRNA,tRNA,miRNA,piRNA,Rfam".split(',')

FOLDERS = "000_index_ref,010_trim_fq,020_align_reads".split(',')


##### target rules #####
rule all:
	input:
		expand(config["outdir"] + "/000_index_ref/{rnatype}/{rnatype}.index.done", rnatype=config["rnatypes"])

rule folders:
    output:
    	["{}/{}".format(config["outdir"], folder) for folder in FOLDERS]
    shell:
    	"mkdir -p -m770 {output}"

rule index_folders:
    output:
    	["{}/000_index_ref/{}".format(config["outdir"], rnatype) for rnatype in config["rnatypes"]]
    shell:
    	"mkdir -p -m770 {output}"


##### load rules #####
include: "rules/common.smk"

include: "rules/index_ref.smk"

#include: "rules/trim_fq.smk"

#include: "rules/align_reads.smk"

#include: "rules/htseq_count.smk"

#include: "rules/samtools_count.smk"

#include: "rules/other.smk"

