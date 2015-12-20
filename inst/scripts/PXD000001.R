library("ProteomicsAnnotationHubData")
library("AnnotationHubData")

PXD000001 <- PAHD("../extdata/PXD000001.dcf")

makePXD000001fasta <-
    function(currentMetadata, justRunUnitTest = FALSE, BiocVersion=biocVersion())
        makeAnnotationHubMetadata(PXD000001, resource = "FASTA")
makePXD000001mzTab <-
    function(currentMetadata, justRunUnitTest = FALSE, BiocVersion=biocVersion())
        makeAnnotationHubMetadata(PXD000001, resource = "mzTab")
makePXD000001mzid <-
    function(currentMetadata, justRunUnitTest = FALSE, BiocVersion=biocVersion())
        makeAnnotationHubMetadata(PXD000001, resource = "mzid")
makePXD000001mzML <-
    function(currentMetadata, justRunUnitTest = FALSE, BiocVersion=biocVersion())
        makeAnnotationHubMetadata(PXD000001, resource = "mzML")

makeAnnotationHubResource("PXD000001FastaToAAStringSetPreparer", makePXD000001fasta)
makeAnnotationHubResource("PXD000001MzTabToMSnSetPreparer", makePXD000001mzTab)
makeAnnotationHubResource("PXD000001MzidToMzRidentPreparer", makePXD000001mzid)
makeAnnotationHubResource("PXD000001MzMLToMzRPwizPreparer", makePXD000001mzML)


PXD000001MzTabToMSnSet <- function(ahm) {
    ## Imports: MSnbase
    if (file.exists(outputFile(ahm)))
        return(outputFile(ahm))
    fin <- inputFiles(ahm) ## get file name on the ftp site
    fout <- outputFile(ahm)
    fl <- download.file(fin, fout)
    msnset <- MSnbase::readMzTabData(fin, what = "PEP", version = "0.9")
    save(msnset, file = "F063721.dat-MSnSet.rda")
    outputFile(ahm)
}

PXD000001FastaToAAStringSet <- function(ahm) {
    ## Imports: Biostrings
    if (file.exists(outputFile(ahm)))
        return(outputFile(ahm))
    fin <- inputFiles(ahm) ## get file name on the ftp site
    fout <- outputFile(ahm)
    fl <- download.file(fin, fout)
    fas <- Biostrings::readAAStringSet(fin)
    save(fas, file = "erwinia_carotovora.rda")
    outputFile(ahm)
}

insertFlag <- FALSE
## metadataOnly should be FALSE, when saving the Rda file on amazon S3
mdonly <- TRUE

PXD000001Fasta <-
    AnnotationHubData::updateResources(ahroot, insert = insertFlag,
                                       preparerClasses = "PXD000001FastaToAAStringSetPreparer",
                                       metadataOnly = mdonly , justRunUnitTest = FALSE)

PXD000001MSnSet <-
    AnnotationHubData::updateResources(ahroot, insert = insertFlag,
                                       preparerClasses = "PXD000001MzTabToMSnSetPreparer",
                                       metadataOnly = mdonly , justRunUnitTest = FALSE)

PXD000001MzML <-
    AnnotationHubData::updateResources(ahroot, insert = insertFlag,
                                       preparerClasses = "PXD000001MzMLToMzRPwizPreparer",
                                       metadataOnly = mdonly , justRunUnitTest=FALSE)

PXD000001MzID <-
    AnnotationHubData::updateResources(ahroot, insert = insertFlag,
                                       preparerClasses = "PXD000001MzidToMzRidentPreparer",
                                       metadataOnly = mdonly , justRunUnitTest = FALSE)

## save for unit tests
save(PXD000001Fasta, file = "../extdata/PXD000001Fasta.rda")
save(PXD000001MSnSet, file = "../extdata/PXD000001MSnSet.rda")
save(PXD000001MzML, file = "../extdata/PXD000001MzML.rda")
save(PXD000001MzID, file = "../extdata/PXD000001MzID.rda")
