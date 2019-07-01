#!/bin/sh

function Usage {
    echo "Usage: $1 <alignment_directory> <rnatype> <output_file> <log>"
}

if (( $# < 4 )) || (( $# > 4 )); then
    Usage $0
    exit 1
fi


ALN=$1
TYP=$2
OUT=$3
LOG=$4

nIDX=0
for F in `find ${ALN}/*/*${TYP}*alignment_statistics.txt`; do
	if [[ "$nIDX" -eq 0 ]]; then
		head -1 ${F} > ${OUT}
	fi
	
	sed -n '2,$p' ${F} >> ${OUT}
	
	nIDX=$(($nIDX + 1))
done

echo "See alignment statistics in ${OUT}" > ${LOG}

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
