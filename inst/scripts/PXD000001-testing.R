library("AnnotationHubData")
library("ProteomicsAnnotationHubData")

ahroot <- "/var/FastRWeb/web"
BiocVersion <- c("3.2")
insertFlag <- FALSE


## metadataOnly should be FALSE, when saving the Rda file on amazon S3

(prot1 <- updateResources(ahroot, BiocVersion, insert = insertFlag,
                          preparerClasses = "PXD000001MzMLToMzRPwizPreparer",
                          metadataOnly=TRUE , justRunUnitTest=FALSE))

(prot2 <- updateResources(ahroot, BiocVersion, insert = insertFlag ,
                          preparerClasses = "PXD000001MzTabToMSnSetPreparer",
                          metadataOnly = TRUE , justRunUnitTest = FALSE))

(prot3 <- updateResources(ahroot, BiocVersion,insert = insertFlag ,
                          preparerClasses = "PXD000001MzidToMzRidentPreparer",
                          metadataOnly = TRUE , justRunUnitTest = FALSE))

(prot4 <- updateResources(ahroot, BiocVersion,insert = insertFlag, 
                          preparerClasses = "PXD000001MzMLToAAStringSetPreparer",
                          metadataOnly = TRUE , justRunUnitTest = FALSE))
