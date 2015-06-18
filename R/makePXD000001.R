.prideDir <- "pride/data/archive/2012/03/PXD000001/"
.prideFullUrl <- file.path(.prideBaseUrl, .prideDir)

fls <- c("TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01-20141210.mzML",
         "F063721.dat-mztab.txt",
         "TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01-20141210.mzid",
         "erwinia_carotovora.fasta")

.SourceType <- c("mzML", "mzTab", "mzid", "FASTA")
.DispatchClass <- .RDataClass <- c("mzRpwiz", "MSnSet", "mzRident", "AAStringSet")

## Only if prepare rda file on AH Amazon instance
PXD00001MzTabToMSnSet <- function(ahm) {
    ## Imports: rpx, mzR
    if (file.exists(outputFile(ahm))) 
        return(outputFile(ahm))

    fin <- inputFiles(ahm) ## get file name on the ftp site
    fout <- outputFile(ahm)    
    fl <- download.file(fin, fout)
    msnset <- MSnbase::readMzTabData(fin, what = "PEP")
    save(msnset, file = "F063721.dat-MSnSet.rda")
   
    outputFile(ahm)    
}

.Recipe <- c(NA_character_,
             "PXD000001MzTabToMSnSet",
             NA_character_,
             NA_character_)

flInfo <- Map(.ftpFileInfo, url = .prideFullUrl,
              filename = fls, tag = NA_character_)

flInfo <- do.call(rbind, flInfo)
flInfo$date <- as.character(flInfo$date)

.Title <- "Four human TMT spliked-in proteins in an Erwinia carotovora background"
.Description <- .expandLine("Expected reporter ion ratios: Erwinia peptides: 1:1:1:1:1:1;
                            Enolase spike (sp|P00924|ENO1_YEAST): 10:5:2.5:1:2.5:10;
                            BSA spike (sp|P02769|ALBU_BOVIN): 1:2.5:5:10:5:1;
                            PhosB spike (sp|P00489|PYGM_RABIT): 2:2:2:2:1:1;
                            Cytochrome C spike (sp|P62894|CYC_BOVIN): 1:1:1:1:1:2.")

.Genome <- NA_character_
.TaxonomyId <- 554L
.Species <- "Erwinia carotovora"
.DataProvider <- ProteomicsAnnotationHubDataProviders['PRIDE']
.Maintainer <- "Laurent Gatto <lg390@cam.ac.uk>"
.RDataPath <- file.path(.prideDir, fls)
.Tags <- c("Proteomics", "TMT6", "LTQ Orbitrap Velos", "PMID:23692960")

AHMRecord <- function(currentMetadata, justRunUnitTest) 
    AHMlist

AHMlist <- lapply(seq_along(fls),
                  function(i)
                      AnnotationHubMetadata(
                          Title = .Title,
                          Description = .Description,
                          SourceType = .SourceType[i],
                          SourceUrl = flInfo[i, 1],
                          SourceVersion = flInfo[i, 2],
                          Species = .Species,
                          Genome = .Genome,
                          TaxonomyId = .TaxonomyId,
                          RDataPath = .RDataPath[i],
                          DataProvider = .DataProvider,
                          Maintainer = .Maintainer,
                          RDataClass =  .RDataClass[i],
                          BiocVersion  =  BiocInstaller::biocVersion(),
                          RDataDateAdded = Sys.time(),
                          Location_Prefix = .prideBaseUrl,
                          Recipe  =  .Recipe,
                          DispatchClass = .DispatchClass,
                          Tags =  .Tags)
                  )

## makeAnnotationHubResource("PXD000001MzMLToMzRPwizPreparer",
##                           AHMRecord)

## makeAnnotationHubResource("PXD000001MzTabToMSnSetPreparer",
##                           AHMRecord)

## makeAnnotationHubResource("PXD000001MzMLToAAStringSetPreparer",
##                           AHMRecord)

## makeAnnotationHubResource("PXD000001MzidToMzRidentPreparer",
##                           AHMRecord)
