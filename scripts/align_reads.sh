#!/bin/sh

function Usage {
    echo "Usage: $1 <bowtie_bin_file> <samtools_bin_file> <seed_len> <max_multihits> <extra_parameters> <refidx> <input_fastq> <align_bam> <logfile>"
}

if (( $# < 9 )) || (( $# > 9 )); then
    Usage $0
    exit 1
fi


BWT=$1
SMT=$2
SLN=$3
MXH=$4
EXP=$5
IDX=$6
INP=$7
OUT=$8
LOG=$9

if [ ! -e "${BWT}" ]; then
	echo "Error! Missing file ${BWT}!"
	exit 1
fi

if [ ! -e "${SMT}" ]; then
	echo "Error! Missing file ${SMT}!"
	exit 1
fi

if [ ! -e "${IDX}.rev.2.ebwt" ]; then
	echo "Error! Missing file ${IDX}.rev.2.ebwt!"
	exit 1
fi

SAM=`echo ${OUT} | sed -e 's/bowtie.bam/bowtie.sam/'`

#FQS = `cat ${INP} | tr '\n' ',' | sed -e 's/,$//'`
FQS=${INP}

${BWT} --seedlen ${SLN} -m ${MXH} ${EXP} ${IDX} ${FQS} ${SAM} 2>&1 | tee ${LOG}

eStatus=$?
if [ $eStatus -eq 0 ];then
   echo "Success! Alignment of reads in ${FQS} to ${SAM} succesful!"
else
   echo "Error! Alignment of reads in ${FQS} to ${SAM} failed!"
   exit 1
fi

${SMT} view -bhS -F4 -o ${OUT} ${SAM}

eStatus=$?
if [ $eStatus -eq 0 ];then
   echo "Success! Conversion of ${SAM} to ${OUT} succesful!"
   rm ${SAM}
else
   echo "Error! Conversion of ${SAM} to ${OUT} failed!"
   exit 1
fi

SID=`basename ${OUT} | cut -d'.' -f1`
REF=`basename ${OUT} | cut -d'.' -f2`
PFX=`echo ${OUT} | sed -e 's/.bam//'`

printf "#Sample.ID\tReference\tTotal.Reads\tMapped.Reads\tUnmapped.Reads\tPercent.Mapped\n" > ${PFX}.alignment_statistics.txt
TR=`grep "# reads processed" ${LOG} | cut -d':' -f2 | awk '{print $1}'`
MR=`grep "# reads with at least one reported alignment" ${LOG} | cut -d':' -f2 | awk '{print $1}'`
UN=`grep "# reads that failed to align" ${LOG} | cut -d':' -f2 | awk '{print $1}'`
MM=`grep "# reads with alignments suppressed due to -m" ${LOG} | cut -d':' -f2 | awk '{print $1}'`
printf "${SID} ${REF} ${TR} ${MR} ${UN} ${MM}" | awk '{printf $1"\t"$2"\t"$3"\t"$4"\t"($5 + $6)"\t"; printf "%0.2f\n", (($4 *100) / $3)}' >> ${PFX}.alignment_statistics.txt

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
