.prideDir <- "pride/data/archive/2012/03/PXD000001/"

## FILES:
## 1. erwinia_carotovora.fasta: from PRIDE server, stored as
##    AAStringSet on AH S3.
## 2. F063721.dat-mztab.txt: from PRIDE, stored as MSnSet on AH S3.
## 3. TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01-20141210.mzid:
##    from AH S4 server, loaded by mzR:openIDfile.
## 4. TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01-20141210.mzML:
##    from PRIDE server, load by mzR::openMSfile.
n <- 4

PXD000001 <- list(
    Title = c(
        "PXD000001: Erwinia carotovora and spiked-in protein fasta file",
        "PXD000001: Peptide-level quantitation data",
        "PXD000001: MS-GF+ identiciation data",
        "PXD000001: raw mass spectrometry data"),
    Description =  AnnotationHubData:::.expandLine(
        "Four human TMT spliked-in proteins in an Erwinia carotovora background.
         Expected reporter ion ratios: Erwinia peptides: 1:1:1:1:1:1;
         Enolase spike (sp|P00924|ENO1_YEAST): 10:5:2.5:1:2.5:10;
         BSA spike (sp|P02769|ALBU_BOVIN): 1:2.5:5:10:5:1;
         PhosB spike (sp|P00489|PYGM_RABIT): 2:2:2:2:1:1;
         Cytochrome C spike (sp|P62894|CYC_BOVIN): 1:1:1:1:1:2."),
    SourceType = c("FASTA", "mzTab", "mzid", "mzML"),
    Recipe = c(
        "ProteomicsAnnotationHubData:::PXD000001FastaToAAStringSet",
        "ProteomicsAnnotationHubData:::PXD000001MzTabToMSnSet",
        NA_character_,
        NA_character_),
    RDataPath = c(
        "pride/data/archive/2012/03/PXD000001/erwinia_carotovora.rda",
        "pride/data/archive/2012/03/PXD000001/F063721.dat-MSnSet.rda",
        "pride/data/archive/2012/03/PXD000001/TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01-20141210.mzid",
        "pride/data/archive/2012/03/PXD000001/TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01-20141210.mzML"
    ),
    Location_Prefix = c(
        AnnotationHubData:::.amazonBaseUrl,
        AnnotationHubData:::.amazonBaseUrl,
        AnnotationHubData:::.amazonBaseUrl, 
        .prideBaseUrl),
    SourceBaseUrl = c(
        .prideBaseUrl,
        .prideBaseUrl,
        AnnotationHubData:::.amazonBaseUrl,
        .prideBaseUrl
    ),
    Species = "Erwinia carotovora",
    Genome = NA_character_, 
    TaxonomyId = 554L,
    File = c("erwinia_carotovora.fasta",
             "F063721.dat-mztab.txt",
             "TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01-20141210.mzid",
             "TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01-20141210.mzML"),
    DataProvider = "PRIDE",
    Maintainer = "Laurent Gatto <lg390@cam.ac.uk>", 
    RDataClass = c("AAStringSet", "MSnSet", "mzRident", "mzRpwiz"),
    DispatchClass = c("AAStringSet", "MSnSet", "mzRident", "mzRpwiz"),
    Tags = list(c("Proteomics", "TMT6", "LTQ Orbitrap Velos", "PMID:23692960")))

PXD000001 <- fixMetaDataList(PXD000001, n)
PXD000001 <- addSourceUrlVersion(PXD000001)
PXD000001 <- orderMetaDataList(PXD000001)
checkMetaDataList(PXD000001, n)

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

## library("ProteomicsAnnotationHubData")

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
