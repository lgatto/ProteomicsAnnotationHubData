library("AnnotationHubData")
library("ProteomicsAnnotationHubData")

ahroot <- "/var/FastRWeb/web"
BiocVersion <- c("3.2") ## as.character(BiocInstaller:::biocVersion())
insertFlag <- FALSE


## metadataOnly should be FALSE, when saving the Rda file on amazon S3
mdonly <- TRUE
dte <- gsub(" ", "-", date())

PXD000001Fasta <- updateResources(ahroot, BiocVersion,insert = insertFlag, 
                                  preparerClasses = "PXD000001FastaToAAStringSetPreparer",
                                  metadataOnly = mdonly , justRunUnitTest = FALSE)
save(PXD000001Fasta, file = paste0("../extdata/PXD000001Fasta-", dte, ".rda"))

PXD000001MSnSet <- updateResources(ahroot, BiocVersion, insert = insertFlag ,
                                   preparerClasses = "PXD000001MzTabToMSnSetPreparer",
                                   metadataOnly = mdonly , justRunUnitTest = FALSE)
save(PXD000001MSnSet, file = paste0("../extdata/PXD000001MSnSet-", dte, ".rda"))

PXD000001MzML <- updateResources(ahroot, BiocVersion, insert = insertFlag,
                                 preparerClasses = "PXD000001MzMLToMzRPwizPreparer",
                                 metadataOnly = mdonly , justRunUnitTest=FALSE)
save(PXD000001MzML, file = paste0("../extdata/PXD000001MzML-", dte, ".rda"))

PXD000001MzID <- updateResources(ahroot, BiocVersion,insert = insertFlag ,
                                preparerClasses = "PXD000001MzidToMzRidentPreparer",
                                metadataOnly = mdonly , justRunUnitTest = FALSE)
save(PXD000001MzID, file = paste0("../extdata/PXD000001MzID-", dte, ".rda"))


