rule merge_expr:
    input:
        
    params:
    	ref=lambda wildcards: config["rnatypes"][wildcards.rnatype], 
    	cntdir=config["outdir"] + "/030_read_counts"
    priority:
    	65
    output:
    	cntmtx=config["outdir"] + "/030_read_counts/000_count_matrix/{rnatype}.count_matrix.txt"
    log:
    	logfile=config["outdir"] + "/030_read_counts/000_count_matrix/{rnatype}.count_matrix.log"
    message:
    	"### Merging counts for {params.ref}"
    shell:
    	'./scripts/merge_expr.sh {params.cntdir} {params.ref} {output.cntmtx} {log}'
