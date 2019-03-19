#!/bin/sh

function Usage {
    echo "Usage: $1 <bowtie_bin_file> <samtools_bin_file> <extra_parameters> <refidx> <input_fastq> <align_bam> <logfile>"
}

if (( $# < 7 )) || (( $# > 7 )); then
    Usage $0
    exit 1
fi


BWT=$1
SMT=$2
EXP=$3
IDX=$4
INP=$5
OUT=$6
LOG=$7

if [ ! -e "${BWT}" ]; then
	echo "Error! Missing file ${BWT}!"
	exit 1
fi

if [ ! -e "${SMT}" ]; then
	echo "Error! Missing file ${SMT}!"
	exit 1
fi

if [ ! -e "${IDX}" ]; then
	echo "Error! Missing file ${IDX}!"
	exit 1
fi

SAM=`echo ${OUT} | sed -e 's/bowtie.bam/bowtie.sam/'`

${BWT} ${EXP} ${IDX} ${INP} ${SAM} | tee ${LOG}

eStatus=$?
if [ $eStatus -eq 0 ];then
   echo "Success! Alignment of reads in ${INP} to ${SAM} succesful!"
else
   echo "Error! Alignment of reads in ${INP} to ${SAM} failed!"
   exit 1
fi

${SMT} view -bhS -o ${OUT} ${SAM}

eStatus=$?
if [ $eStatus -eq 0 ];then
   echo "Success! Conversion of ${SAM} to ${OUT} succesful!"
else
   echo "Error! Conversion of ${SAM} to ${OUT} failed!"
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
