#!/bin/sh

function Usage {
    echo "Usage: $1 <samtools_bin_file> <input_bam> <sorted_bam>"
}

if (( $# < 3 )) || (( $# > 3 )); then
    Usage $0
    exit 1
fi


SMT=$1
INP=$2
OUT=$3

if [ ! -e "${SMT}" ]; then
	echo "Error! Missing file ${SMT}!"
	exit 1
fi

${SMT} sort -o ${OUT} ${INP}

eStatus=$?
if [ $eStatus -eq 0 ];then
   echo "Success! Sorting of reads in ${INP} to ${OUT} succesful!"
else
   echo "Error! Sorting of reads in ${INP} to ${OUT} failed!"
   exit 1
fi

${SMT} index ${OUT}

eStatus=$?
if [ $eStatus -eq 0 ];then
   echo "Success! Indexing of ${OUT} succesful!"
else
   echo "Error! Indexing of ${OUT} failed!"
   exit 1
fi

PFX=`echo ${OUT} | sed -e 's/.bam//'`

${SMT} flagstat ${OUT} > ${PFX}.mapstats.txt

eStatus=$?
if [ $eStatus -eq 0 ];then
   echo "Success! Alignment statistics of ${OUT} to ${PFX}.mapstats.txt succesful!"
else
   echo "Error! Alignment statistics of ${OUT} to ${PFX}.mapstats.txt failed!"
   exit 1
fi

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
