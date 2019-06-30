rule align_fastq:
    input:
        
    params:
    	bwtbin=config["params"]["bowtie"], 
    	sambin=config["params"]["samtools"], 
    	trimfq=lambda wildcards: get_trimmed_fastq(wildcards.sample), 
    	extra="-v 2 -q --all --best --strata --sam", 
    	refdir=config["outdir"] + "/000_index_ref", 
    	idxdir=lambda wildcards: config[wildcards.rnatype]["outdir"], 
    	prefix=lambda wildcards: get_index_prefix(config[wildcards.rnatype]["sequence"]), 
    	seedlen=lambda wildcards: config[wildcards.rnatype]["seedlen"], 
    	maxhits=lambda wildcards: config[wildcards.rnatype]["maxhits"]
    priority:
    	80
    output:
    	bam=config["outdir"] + "/020_align_reads/{sample}/{sample}.{rnatype}.bowtie.bam"
    log:
    	logfile=config["outdir"] + "/020_align_reads/{sample}/{sample}.{rnatype}.bowtie.align.log"
    message:
    	"### Aligning reads for the following file {params.trimfq}"
    shell:
    	'./scripts/align_reads.sh {params.bwtbin} {params.sambin} {params.seedlen} {params.maxhits} \'{params.extra}\' {params.refdir}/{params.idxdir}/{params.prefix} {params.trimfq} {output.bam} {log}'
