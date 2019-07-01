rule sort_align:
    input:
        bam=config["outdir"] + "/020_align_reads/{sample}/{sample}.{rnatype}.bowtie.bam"
    params:
    	sambin=config["params"]["samtools"]
    output:
    	sortedbam=config["outdir"] + "/020_align_reads/{sample}/{sample}.{rnatype}.bowtie.sorted.bam"
    priority:
    	73
    message:
    	"### Sorting alignments for the following file {input.bam}"
    shell:
    	'./scripts/sort_align.sh {params.sambin} {input.bam} {output.sortedbam}'
