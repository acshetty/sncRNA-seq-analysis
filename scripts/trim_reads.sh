#!/bin/sh

function Usage {
    echo "Usage: $1 <trimmomatic_jar_file> <extra_parameters> <logfile> <input_fastq> <trimmed_fastq> <adapter_fasta> <min_read_length>"
}

if (( $# < 7 )) || (( $# > 7 )); then
    Usage $0
    exit 1
fi


JAR=$1
EXP=$2
LOG=$3
INP=$4
OUT=$5
ADP=$6
MRL=$7

if [ ! -e "${JAR}" ]; then
	echo "Error! Missing file ${JAR}!"
	exit 1
fi

java -jar ${JAR} ${EXP} -trimlog ${LOG} ${INP} ${OUT} ILLUMINACLIP:${ADP} MINLEN:${MRL}

eStatus=$?
if [ $eStatus -eq 0 ];then
   echo "Success! Trimming of reads in ${INP} succesful!"
else
   echo "Error! Trimming of reads in ${INP} failed!"
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
