rule compute_count:
    input:
        bam=config["outdir"] + "/020_align_reads/{sample}/{sample}.{rnatype}.bowtie.bam"
    params:
    	sambin=config["params"]["samtools"]
    output:
    	cnt=config["outdir"] + "/030_read_counts/{sample}/{sample}.{rnatype}.bowtie.count"
    message:
    	"### Computing ncRNA counts for the following file {input.bam}"
    shell:
    	'echo ./scripts/compute_count.sh {params.sambin} {input.bam} {output.cnt}'
