library("AnnotationHubData")
library("ProteomicsAnnotationHubData")

ahroot <- "/var/FastRWeb/web"
BiocVersion <- c("3.2") ## as.character(BiocInstaller:::biocVersion())
insertFlag <- FALSE


## metadataOnly should be FALSE, when saving the Rda file on amazon S3
mdonly <- TRUE

PXD000001Fasta <- updateResources(ahroot, BiocVersion,insert = insertFlag, 
                                  preparerClasses = "PXD000001FastaToAAStringSetPreparer",
                                  metadataOnly = mdonly , justRunUnitTest = FALSE)

PXD000001MSnSet <- updateResources(ahroot, BiocVersion, insert = insertFlag ,
                                   preparerClasses = "PXD000001MzTabToMSnSetPreparer",
                                   metadataOnly = mdonly , justRunUnitTest = FALSE)

PXD000001MzML <- updateResources(ahroot, BiocVersion, insert = insertFlag,
                                 preparerClasses = "PXD000001MzMLToMzRPwizPreparer",
                                 metadataOnly = mdonly , justRunUnitTest=FALSE)

PXD000001MzID <- updateResources(ahroot, BiocVersion,insert = insertFlag ,
                                preparerClasses = "PXD000001MzidToMzRidentPreparer",
                                metadataOnly = mdonly , justRunUnitTest = FALSE)

## Stored for unit testing
## dte <- gsub(" ", "-", date()) ## "Fri-Jul-31-02:00:27-2015"
## saveRDS(PXD000001Fasta, file = paste0("../extdata/PXD000001Fasta-", dte, ".rds"))
## saveRDS(PXD000001MSnSet, file = paste0("../extdata/PXD000001MSnSet-", dte, ".rds"))
## saveRDS(PXD000001MzML, file = paste0("../extdata/PXD000001MzML-", dte, ".rds"))
## saveRDS(PXD000001MzID, file = paste0("../extdata/PXD000001MzID-", dte, ".rds"))
