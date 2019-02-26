rule index_fasta:
    input:
        lambda wildcards: config[wildcards.rnatype]["sequence"]
    params:
    	bin=config["params"]["bowtie-build"], 
    	outdir=lambda wildcards: config[wildcards.rnatype]["outdir"], 
    	prefix=lambda wildcards: get_index_prefix(config[wildcards.rnatype]["sequence"])
    output:
        config["outdir"] + "/000_index_ref/{rnatype}/{rnatype}.index.done"
    message:
    	"### Indexing of the following file {input}"
    shell:
    	'echo ./scripts/bowtie_index.sh {params.bin} {input} {params.outdir} {params.prefix}'
