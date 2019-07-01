rule merge_alignment_stats:
    input:
        
    params:
    	ref=lambda wildcards: config["rnatypes"][wildcards.rnatype], 
    	alndir=config["outdir"] + "/020_align_reads"
    priority:
    	77
    output:
    	alnstat=config["outdir"] + "/020_align_reads/000_alignment_statistics/{rnatype}.alignment_statistics.txt"
    log:
    	logfile=config["outdir"] + "/020_align_reads/000_alignment_statistics/{rnatype}.alignment_statistics.log"
    message:
    	"### Alignment statistics for {params.ref}"
    shell:
    	'./scripts/merge_alignment_statistics.sh {params.alndir} {params.ref} {output.alnstat} {log}'
