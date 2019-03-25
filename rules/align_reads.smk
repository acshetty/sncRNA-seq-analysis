def get_trimmed_fastq(wildcards):
    # returns a list of trimmed fastq files based on *wildcards.sample*
    return sorted(glob.glob(config["outdir"] + "/010_trim_fq/" + wildcards.sample + "*.trimmed.fastq.gz"))

rule align_fastq:
    input:
        trimfq=get_trimmed_fastq, 
        refseq=lambda wildcards: config[wildcards.rnatype]["sequence"]
    params:
    	bwtbin=config["params"]["bowtie"], 
    	sambin=config["params"]["samtools"], 
    	extra="-v 2 --seedlen 15 -m 5 -q --all --best --strata --sam", 
    	wrkdir=config["outdir"] + "/000_index_ref", 
    	idxdir=lambda wildcards: config[wildcards.rnatype]["outdir"], 
    	prefix=lambda wildcards: get_index_prefix(config[wildcards.rnatype]["sequence"])
    priority:
    	80
    output:
    	bam=config["outdir"] + "/020_align_reads/{sample}/{sample}.{rnatype}.bowtie.bam"
    log:
    	logfile=config["outdir"] + "/020_align_reads/{sample}/{sample}.{rnatype}.bowtie.align.log"
    message:
    	"### Aligning reads for the following file {input.trimfq}"
    shell:
    	'./scripts/align_reads.sh {params.bwtbin} {params.sambin} \'{params.extra}\' {params.wrkdir}/{params.idxdir}/{params.prefix} {input.trimfq} {output.bam} {log}'
