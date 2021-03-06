#!/usr/bin/env nextflow

/*
#==============================================
code documentation
#==============================================
*/


/*
#==============================================
params
#==============================================
*/

params.fastqcResultsDir = 'results/fastqc'
params.resultsDir = 'results/multiqc'
params.saveMode = 'copy'

Channel.fromPath("""${params.fastqcResultsDir}""")
        .set { ch_in_multiqc }

/*
#==============================================
multiqc
#==============================================
*/

process multiQC {
    publishDir params.resultsDir, mode: params.saveMode
    container 'quay.io/biocontainers/multiqc:1.9--pyh9f0ad1d_0'

    input:
    path("""${params.fastqcResultsDir}""") from ch_in_multiqc

    output:
    tuple path("""multiqc_data"""),
            path("""multiqc_report.html""") into ch_out_multiqc


    script:

    """
    multiqc ${params.fastqcResultsDir}
    """

}


/*
#==============================================
# extra
#==============================================
*/
