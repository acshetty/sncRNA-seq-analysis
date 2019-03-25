rule compute_count:
    input:
        bam=config["outdir"] + "/020_align_reads/{sample}/{sample}.{rnatype}.bowtie.sorted.bam"
    params:
    	sambin=config["params"]["samtools"]
    output:
    	cnt=config["outdir"] + "/030_read_counts/{sample}/{sample}.{rnatype}.bowtie.sorted.count"
    priority:
    	70
    message:
    	"### Computing ncRNA counts for the following file {input.bam}"
    shell:
    	'./scripts/compute_count.sh {params.sambin} {input.bam} {output.cnt}'
