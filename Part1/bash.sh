fastqc SRR22085415.fastq				
bwa index ref_genomic.fna
bwa mem ref_genomic.fna SRR22085415.fastq.gz > result.sam						
samtools flagstat result.sam > final
python3 quality_check.py final