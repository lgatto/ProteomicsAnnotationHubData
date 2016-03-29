##' Read the \code{ProteomicsAnnotationHubData} vignette to get
##' started with using Proteomics data from AnnotationHub and writing
##' new recipes. Use \code{availableProteomicsAnnotationHubData()} to
##' get a vector of available experiments. Use
##' \code{proteomicsAnnotationHubDataResources()} to get a
##' vector of available resources.
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

##' @rdname ProteomicsAnnotationHubData
proteomicsAnnotationHubDataResources <-
    c("FASTA", "mzTab", "mzid", "mzML")

## less typing
AnnotationHubMetadata <- AnnotationHubData:::AnnotationHubMetadata
.expandLine <- AnnotationHubData:::.expandLine
.amazonBaseUrl <- AnnotationHubData:::.amazonBaseUrl

## Global variables
.prideBaseUrl <- "ftp://ftp.pride.ebi.ac.uk/"
ahroot <- "/var/FastRWeb/web"
BiocVersion <- as.character(BiocInstaller:::biocVersion()) ## "3.3"

ProteomicsAnnotationHubDataProviders <-
    list(PRIDE = c(name = "PRIDE", baseUrl = .prideBaseUrl),
         AHS3 = c(name = "AHS3", baseUrl = .amazonBaseUrl))

ProteomicsAnnotationHubDataTags <-
    c("Proteomics",
      "TMT6", "TMT10", "iTRAQ4", "iTRAQ8",
      "LFQ", "SC", "SILAC",
      "PMID:1234567",
      "SWATH", "MSE", "MRM", "SRM", "PRM",
      "Instrument name")
