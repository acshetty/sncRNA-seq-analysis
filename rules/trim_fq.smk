def get_fastq(wildcards):
	# returns a list of fastq files based on *wildcards.sample* and *wildcards.unit*
    return units.loc[(wildcards.sample, wildcards.unit), ["fq1", "fq2"]].dropna()

rule trim_fastq:
    input:
        get_fastq
    params:
    	bin=config["params"]["trimmomatic"], 
    	extra="SE -phred33", 
    	adapter=config["adapter"], 
    	minlength=config["params"]["minlength"]
    output:
        trimfq=config["outdir"] + "/010_trim_fq/{sample}_{unit}.trimmed.fastq.gz"
    priority:
    	90
    log:
    	logfile=config["outdir"] + "/010_trim_fq/{sample}_{unit}.trimmed.log"
    message:
    	"### Trimming reads for the following file {input}"
    shell:
    	'./scripts/trim_reads.sh {params.bin} \'{params.extra}\' {log} {input} {output.trimfq} {params.adapter} {params.minlength}'
