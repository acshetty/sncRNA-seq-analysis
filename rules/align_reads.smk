rule align_fastq:
    input:
        
    params:
    	bwtbin=config["params"]["bowtie"], 
    	sambin=config["params"]["samtools"], 
    	trimfq=lambda wildcards: get_trimmed_fastq(wildcards.sample), 
    	extra="-v 2 --seedlen 15 -m 5 -q --all --best --strata --sam", 
    	refdir=config["outdir"] + "/000_index_ref", 
    	idxdir=lambda wildcards: config[wildcards.rnatype]["outdir"], 
    	prefix=lambda wildcards: get_index_prefix(config[wildcards.rnatype]["sequence"])
    priority:
    	80
    output:
    	bam=config["outdir"] + "/020_align_reads/{sample}/{sample}.{rnatype}.bowtie.bam"
    log:
    	logfile=config["outdir"] + "/020_align_reads/{sample}/{sample}.{rnatype}.bowtie.align.log"
    message:
    	"### Aligning reads for the following file {input}"
    shell:
    	'./scripts/align_reads.sh {params.bwtbin} {params.sambin} \'{params.extra}\' {params.refdir}/{params.idxdir}/{params.prefix} {params.trimfq} {output.bam} {log}'
