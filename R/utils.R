.prideBaseUrl <- "ftp://ftp.pride.ebi.ac.uk"

AnnotationHubMetadata <- AnnotationHubData:::AnnotationHubMetadata
.expandLine <- AnnotationHubData:::.expandLine

.ftpFileInfo <- function(...) {
    flInfo <- AnnotationHubData:::.ftpFileInfo(...)
    if (is.na(flInfo$date)) flInfo$date <- Sys.time()
    flInfo
}

ProteomicsAnnotationHubDataProviders <-
    c(PRIDE = "PRIDE")

ProteomicsAnnotationHubDataTags <-
    c("Proteomics",
      "TMT6", "TMT10", "iTRAQ4", "iTRAQ8",
      "LFQ", "SC", "SILAC",
      "PMID:1234567",
      "Instrument name")
