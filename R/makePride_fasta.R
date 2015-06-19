makePride_fasta <- function(currentMetadata, justRunUnitTest=FALSE){

    .prideDir <- "pride/data/archive/2012/03/PXD000001/"
    .prideFullUrl <- paste0(.prideBaseUrl, .prideDir)
    fls <- "erwinia_carotovora.fasta"

    .locationPrefix <- .prideBaseUrl
    .SourceType <- "FASTA"
    .DispatchClass <- .RDataClass <- "AAStringSet"
    .Recipe <- NA_character_
    flInfo <- Map(.ftpFileInfo, url = .prideFullUrl,
                  filename = fls, tag = NA_character_)
    flInfo <- do.call(rbind, flInfo)
    flInfo$date <- as.character(flInfo$date)
    .Title <- "Four human TMT spliked-in proteins in an Erwinia carotovora background"
    .Description <-
        .expandLine("Expected reporter ion ratios: Erwinia peptides: 1:1:1:1:1:1;
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


    list(AnnotationHubMetadata(
        Title = .Title,
        Description = .Description,
        SourceType = .SourceType,
        SourceUrl = flInfo[, 1],
        SourceVersion = flInfo[, 2],
        Species = .Species,
        Genome = .Genome,
        TaxonomyId = .TaxonomyId,
           RDataPath = .RDataPath,
        DataProvider = .DataProvider,
        Maintainer = .Maintainer,
        RDataClass =  .RDataClass,
        BiocVersion  =  BiocInstaller::biocVersion(),
        RDataDateAdded = Sys.time(),
        Location_Prefix = .locationPrefix,
        Recipe = NA_character_,
        DispatchClass = .DispatchClass,
        Tags = .Tags))
}

makeAnnotationHubResource("PXD000001MzMLToAAStringSetPreparer", makePride_fasta )
