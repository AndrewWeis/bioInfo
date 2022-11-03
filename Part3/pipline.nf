params.refGenomeEColi = "ref_genomic.fna"
params.actualReadesFromEColiWithoutFormat = "SRR22085415.fastq"

params.outDir = "$baseDir/../Part3/out"
params.inputDir = "$baseDir/../Part3/inputFiles"

params.parsePyScript = "quality_check.py"

process fastQC {
    publishDir "${params.outDir}", mode: 'copy'

    script:
    """
    mkdir -p ${params.outDir}
    fastqc "${params.inputDir}/${params.actualReadesFromEColiWithoutFormat}" -o ${params.outDir}
    """
}

process bwaIndex {
    publishDir "${params.outDir}", mode: 'copy'

    script:
    """
    bwa index ${params.inputDir}/${params.refGenomeEColi}
    """
}

process bwaMem {
    publishDir "${params.outDir}", mode: 'copy'

    output:
      path "*.sam", emit: result_link

    script:
    """
    bwa mem ${params.inputDir}/${params.refGenomeEColi} ${params.inputDir}/${params.actualReadesFromEColiWithoutFormat} > result.sam
    """
}

process samtoolsFlagstat {
    publishDir "${params.outDir}", mode: 'copy'

    input:
      path result_link

    output:
      path "*.txt", emit: final_link

    script:
    """
    samtools flagstat $result_link > final.txt
    """
}

process parsePercent {
      publishDir "${params.outDir}", mode: 'copy'

    input:
      path final_link

    output:
      stdout

    script:
    """
    python3 ${params.inputDir}/${params.parsePyScript} $final_link
    """
}

workflow {
  fastQC()
  bwaIndex()
  bwaMem()
  samtoolsFlagstat(bwaMem.out.result_link)
  parsePercent(samtoolsFlagstat.out.final_link) | view
}
