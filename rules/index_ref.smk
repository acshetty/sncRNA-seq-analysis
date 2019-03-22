rule index_fasta:
    input:
        lambda wildcards: config[wildcards.rnatype]["sequence"]
    params:
    	bin=config["params"]["bowtie-build"], 
    	prefix=lambda wildcards: get_index_prefix(config[wildcards.rnatype]["sequence"])
    output:
        outdir=config["outdir"] + "/000_index_ref/{rnatype}/{rnatype}.index.done"
    priority:
    	4
    message:
    	"### Indexing of the following file {input}"
    shell:
    	'./scripts/bowtie_index.sh {params.bin} {input} {output.outdir} {params.prefix}'
