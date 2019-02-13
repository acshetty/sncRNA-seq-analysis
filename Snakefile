import pandas as pd
from snakemake.utils import validate, min_version

##### set minimum snakemake version #####
min_version("3.2")

##### load config and sample sheets #####
configfile: "config.yaml"
validate(config, schema="schemas/config.schema.yaml")

rule all:
    input:
        # The first rule should define the default target files
        # Subsequent target rules can be specified below. They should start with all_*.


include: "rules/other.smk"
