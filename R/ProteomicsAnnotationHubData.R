##' Read the \code{ProteomicsAnnotationHubData} vignette to get
##' started with using Proteomics data from AnnotationHub and writing
##' new recipes. Use \code{availableProteomicsAnnotationHubData()} to
##' get a vector of available experiments.
##'
##' @title Get started with ProteomicsAnnotationHubData
##' @return Used for its side-effect of opening the package
##'     vignette. A vector of experiment identifiers.
##' @author Laurent Gatto
##' @aliases availableProteomicsAnnotationHubData
##' @examples availableProteomicsAnnotationHubData
ProteomicsAnnotationHubData <- function() 
    vignette("ProteomicsAnnotationHubData",
             package = "ProteomicsAnnotationHubData")

##' @rdname ProteomicsAnnotationHubData
availableProteomicsAnnotationHubData <-
    c("PXD000001")

ahroot <- "/var/FastRWeb/web"
BiocVersion <- as.character(BiocInstaller:::biocVersion()) ## "3.2"
