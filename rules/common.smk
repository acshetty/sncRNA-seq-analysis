def is_single_end(sample, unit):
	return pd.isnull(units.loc[(sample, unit), "fq2"])

def get_index_prefix(fafile):
	return str(os.path.splitext(os.path.basename(fafile))[0])

def get_trimmed_fastq(sample_name):
    # returns a list of trimmed fastq files based on *wildcards.sample*
    return ','.join(sorted(glob.glob(config["outdir"] + "/010_trim_fq/" + sample_name + "*.trimmed.fastq.gz")))


