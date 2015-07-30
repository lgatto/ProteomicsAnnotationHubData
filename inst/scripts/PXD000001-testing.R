library("AnnotationHubData")
library("ProteomicsAnnotationHubData")

ahroot <- "/var/FastRWeb/web"
BiocVersion <- c("3.2")
insertFlag <- FALSE


## metadataOnly should be FALSE, when saving the Rda file on amazon S3

(fas <- updateResources(ahroot, BiocVersion,insert = insertFlag, 
                        preparerClasses = "PXD000001FastaToAAStringSetPreparer",
                        metadataOnly = FALSE , justRunUnitTest = FALSE))

(msn <- updateResources(ahroot, BiocVersion, insert = insertFlag ,
                        preparerClasses = "PXD000001MzTabToMSnSetPreparer",
                        metadataOnly = FALSE , justRunUnitTest = FALSE))

(mzml <- updateResources(ahroot, BiocVersion, insert = insertFlag,
                         preparerClasses = "PXD000001MzMLToMzRPwizPreparer",
                         metadataOnly=TRUE , justRunUnitTest=FALSE))

(mzid <- updateResources(ahroot, BiocVersion,insert = insertFlag ,
                         preparerClasses = "PXD000001MzidToMzRidentPreparer",
                         metadataOnly = TRUE , justRunUnitTest = FALSE))



