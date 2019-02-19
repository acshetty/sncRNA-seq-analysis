rule index_genome_fasta:
    input:
        fasta=config["genome"]["sequence"]
    params:
    	bin=config["params"]["bowtie-build"]
    	outdir="{}/{}".format(config["outdir"], "index/genome")
    	prefix=get_index_prefix(config["genome"]["sequence"])
    output:
        touch("{params.outdir}/Index.done")
    run:
    	shell("ln -s {input.fasta} {params.outdir}")
    	shell("{bin} -f {input.fasta} {params.outdir}/{params.prefix}")

rule index_ncRNA_fasta:
    input:
        fasta=config["ncRNA"]["sequence"]
    params:
    	bin=config["params"]["bowtie-build"]
    	outdir="{}/{}".format(config["outdir"], "index/ncRNA")
    	prefix=get_index_prefix(config["ncRNA"]["sequence"])
    output:
        touch("{params.outdir}/Index.done")
    run:
    	shell("ln -s {input.fasta} {params.outdir}")
    	shell("{bin} -f {input.fasta} {params.outdir}/{params.prefix}")

rule index_rRNA_fasta:
    input:
        fasta=config["rRNA"]["sequence"]
    params:
    	bin=config["params"]["bowtie-build"]
    	outdir="{}/{}".format(config["outdir"], "index/rRNA")
    	prefix=get_index_prefix(config["rRNA"]["sequence"])
    output:
        touch("{params.outdir}/Index.done")
    run:
    	shell("ln -s {input.fasta} {params.outdir}")
    	shell("{bin} -f {input.fasta} {params.outdir}/{params.prefix}")

rule index_tRNA_fasta:
    input:
        fasta=config["tRNA"]["sequence"]
    params:
    	bin=config["params"]["bowtie-build"]
    	outdir="{}/{}".format(config["outdir"], "index/tRNA")
    	prefix=get_index_prefix(config["tRNA"]["sequence"])
    output:
        touch("{params.outdir}/Index.done")
    run:
    	shell("ln -s {input.fasta} {params.outdir}")
    	shell("{bin} -f {input.fasta} {params.outdir}/{params.prefix}")

rule index_miRNA_fasta:
    input:
        fasta=config["miRNA"]["sequence"]
    params:
    	bin=config["params"]["bowtie-build"]
    	outdir="{}/{}".format(config["outdir"], "index/miRNA")
    	prefix=get_index_prefix(config["miRNA"]["sequence"])
    output:
        touch("{params.outdir}/Index.done")
    run:
    	shell("ln -s {input.fasta} {params.outdir}")
    	shell("{bin} -f {input.fasta} {params.outdir}/{params.prefix}")

rule index_piRNA_fasta:
    input:
        fasta=config["piRNA"]["sequence"]
    params:
    	bin=config["params"]["bowtie-build"]
    	outdir="{}/{}".format(config["outdir"], "index/piRNA")
    	prefix=get_index_prefix(config["piRNA"]["sequence"])
    output:
        touch("{params.outdir}/Index.done")
    run:
    	shell("ln -s {input.fasta} {params.outdir}")
    	shell("{bin} -f {input.fasta} {params.outdir}/{params.prefix}")

rule index_Rfam_fasta:
    input:
        fasta=config["Rfam"]["sequence"]
    params:
    	bin=config["params"]["bowtie-build"]
    	outdir="{}/{}".format(config["outdir"], "index/Rfam")
    	prefix=get_index_prefix(config["Rfam"]["sequence"])
    output:
        touch("{params.outdir}/Index.done")
    run:
    	shell("ln -s {input.fasta} {params.outdir}")
    	shell("{bin} -f {input.fasta} {params.outdir}/{params.prefix}")

