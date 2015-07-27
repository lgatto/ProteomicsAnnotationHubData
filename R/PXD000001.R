.prideDir <- "pride/data/archive/2012/03/PXD000001/"

PXD000001 <- list(
    Title = "Four human TMT spliked-in proteins in an Erwinia carotovora background",
    Description =  AnnotationHubData:::.expandLine(
        "Expected reporter ion ratios: Erwinia peptides: 1:1:1:1:1:1;
         Enolase spike (sp|P00924|ENO1_YEAST): 10:5:2.5:1:2.5:10;
         BSA spike (sp|P02769|ALBU_BOVIN): 1:2.5:5:10:5:1;
         PhosB spike (sp|P00489|PYGM_RABIT): 2:2:2:2:1:1;
         Cytochrome C spike (sp|P62894|CYC_BOVIN): 1:1:1:1:1:2."),
    SourceType = c("FASTA", "mzTab", "mzid", "mzML"),
    Recipe = c(
        NA_character_,
        "ProteomicsAnnotationHubData:::PXD00001MzTabToMSnSet",
        NA_character_,
        NA_character_),
    Location_Prefix = c(
        .prideBaseUrl, 
        .prideBaseUrl, 
        AnnotationHubData:::.amazonBaseUrl, 
        .prideBaseUrl),
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
    Recipe = c(NA_character_,
               "ProteomicsAnnotationHubData:::PXD00001MzTabToMSnSet",
               NA_character_,
               NA_character_),
    DispatchClass = c("AAStringSet", "MSnSet", "mzRident", "mzRpwiz"),
    Tags = list(c("Proteomics", "TMT6", "LTQ Orbitrap Velos", "PMID:23692960")))
n <- 4

PXD000001 <- fixMetaDataList(PXD000001, n)
PXD000001 <- addRDataPath(PXD000001) ## calls addSourceUrlVersion
PXD000001 <- orderMetaDataList(PXD000001)
checkMetaDataList(PXD000001, n)

makePXD000001fasta <- function(currentMetadata, justRunUnitTest = FALSE) 
    makeAnnotationHubMetadata(PXD000001, resource = "FASTA")
makePXD000001mzTab <- function(currentMetadata, justRunUnitTest = FALSE)
    makeAnnotationHubMetadata(PXD000001, resource = "mzTab")
makePXD000001mzid <- function(currentMetadata, justRunUnitTest = FALSE)
    makeAnnotationHubMetadata(PXD000001, resource = "mzid")
makePXD000001mzML <- function(currentMetadata, justRunUnitTest = FALSE)
    makeAnnotationHubMetadata(PXD000001, resource = "mzML")

makeAnnotationHubResource("PXD000001MzMLToAAStringSetPreparer", makePXD000001fasta)
makeAnnotationHubResource("PXD000001MzTabToMSnSetPreparer", makePXD000001mzTab)
makeAnnotationHubResource("PXD000001MzidToMzRidentPreparer", makePXD000001mzid)
makeAnnotationHubResource("PXD000001MzMLToMzRPwizPreparer", makePXD000001mzML)

## Preparer function
PXD00001MzTabToMSnSet <- function(ahm) {
    ## Imports: MSnbase
    if (file.exists(outputFile(ahm)))
        return(outputFile(ahm))
    fin <- inputFiles(ahm) ## get file name on the ftp site
    fout <- outputFile(ahm)
    fl <- download.file(fin, fout)
    msnset <- MSnbase::readMzTabData(fin, what = "PEP")
    save(msnset, file = "F063721.dat-MSnSet.rda")
    outputFile(ahm)
}

