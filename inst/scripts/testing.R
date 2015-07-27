library("AnnotationHubData")
library("ProteomicsAnnotationHubData")

ahroot <- "/var/FastRWeb/web"
BiocVersion <- c("3.2")
insertFlag <- FALSE

prot1 <- updateResources(ahroot, BiocVersion, insert = insertFlag,
     preparerClasses = "PXD000001MzMLToMzRPwizPreparer",
     metadataOnly=TRUE , justRunUnitTest=FALSE)

prot2 <- updateResources(ahroot, BiocVersion, insert = insertFlag ,
     preparerClasses = "PXD000001MzTabToMSnSetPreparer",
     metadataOnly = FALSE , justRunUnitTest = FALSE) 
## Above metadata is false, because we are saving the Rda file on amazon S3

prot3 <- updateResources(ahroot, BiocVersion,insert = insertFlag ,
     preparerClasses = "PXD000001MzidToMzRidentPreparer",
     metadataOnly = TRUE , justRunUnitTest = FALSE)

prot4 <- updateResources(ahroot, BiocVersion,insert = insertFlag, 
     preparerClasses = "PXD000001MzMLToAAStringSetPreparer",
     metadataOnly = TRUE , justRunUnitTest = FALSE)
