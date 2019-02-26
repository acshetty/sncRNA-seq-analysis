def is_single_end(sample, unit):
	return pd.isnull(units.loc[(sample, unit), "fq2"])

def get_index_prefix(fafile):
	return str(os.path.splitext(os.path.basename(fafile))[0])
