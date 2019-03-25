import os, sys, glob
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
units['sampleID'] = units[['sample', 'unit']].apply(lambda x: '_'.join(x), axis=1)

RNATYPES = "genome,ncRNA,rRNA,tRNA,miRNA,piRNA,Rfam".split(',')

FOLDERS = "000_index_ref,010_trim_fq,020_align_reads,030_read_counts".split(',')


##### target rules #####
rule all:
	input:
		expand(config["outdir"] + "/000_index_ref/{rnatype}/{rnatype}.index.done", rnatype=config["rnatypes"]), 
		expand(config["outdir"] + "/010_trim_fq/{sampleID}.trimmed.fastq.gz", sampleID=units["sampleID"]), 
		expand(config["outdir"] + "/020_align_reads/{sampleID}/{sampleID}.{rnatype}.bowtie.bam", sampleID=samples["sample"], rnatype=config["rnatypes"]), 
		expand(config["outdir"] + "/020_align_reads/{sampleID}/{sampleID}.{rnatype}.bowtie.sorted.bam", sampleID=samples["sample"], rnatype=config["rnatypes"]), 
		expand(config["outdir"] + "/030_read_counts/{sampleID}/{sampleID}.{rnatype}.bowtie.sorted.count", sampleID=samples["sample"], rnatype=config["rnatypes"])

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

rule trim_folder:
    output:
    	"{}/010_trim_fq".format(config["outdir"])
    shell:
    	"mkdir -p -m770 {output}"

rule align_folders:
    output:
    	["{}/020_align_reads/{}".format(config["outdir"], sampleID) for sampleID in samples["sample"]]
    shell:
    	"mkdir -p -m770 {output}"


##### load rules #####
include: "rules/common.smk"

include: "rules/index_ref.smk"

include: "rules/trim_fq.smk"

include: "rules/align_reads.smk"

include: "rules/sort_align.smk"

include: "rules/compute_expr.smk"

#include: "rules/other.smk"

