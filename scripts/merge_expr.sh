#!/bin/sh

function Usage {
    echo "Usage: $1 <count_directory> <rnatype> <output_file> <log>"
}

if (( $# < 4 )) || (( $# > 4 )); then
    Usage $0
    exit 1
fi


CNT=$1
TYP=$2
OUT=$3
LOG=$4

nIDX=0
for F in `find ${CNT}/*/*${TYP}*bowtie.sorted.count`; do
	if [[ "$nIDX" -eq 0 ]]; then
		printf "ID\n" > ${OUT}
		cut -f1 ${F} >> ${OUT}
	fi
	
	PFX=`basename ${F} | cut -d'.' -f1`
	printf "${PFX}\n" > ${OUT}.${TYP}.count.tmp
	cut -f2 ${F} >> ${OUT}.${TYP}.count.tmp
	
	paste ${OUT} ${OUT}.${TYP}.count.tmp > ${OUT}.tmp
	mv ${OUT}.tmp ${OUT}
	
	rm ${OUT}.${TYP}.count.tmp
	nIDX=$(($nIDX + 1))
done

echo "See count matrix in ${OUT}" > ${LOG}

echo ""

#####################################################################################
### AUTHOR
### 
### Amol Carl Shetty
### Lead Bioinformatics Software Engineer
### Institute of Genome Sciences
### University of Maryland
### Baltimore, Maryland 21201
### 
### =head1 LICENSE AND COPYRIGHT
### 
### Copyright (c) 2019 Amol Carl Shetty (<ashetty@som.umaryland.edu>). All rights
### reserved.
### 
### This program is free software; you can distribute it and/or modify it under
### GNU-GPL licenscing terms.
### 
### This program is distributed in the hope that it will be useful, but WITHOUT
### ANY WARRANTY; without even the implied warranty of MERCHANTIBILITY or FITNESS
### FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
### BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
### CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
### GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
### HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
### LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
### OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#####################################################################################
