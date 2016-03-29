##' An S4 class for ProteomicsAnnotationHubData objects
##'
##' This class is a simple temporary container that extends the
##' \code{AnnotationHubMetadata}. Please read that documentation for
##' details. This class is likely to evolve in the future. See
##' \code{\link{PAHD}} for to construct these objects from dcf files.
.PAHD <- setClass("PAHD",
                  contains = c("AnnotationHubMetadata",
                               "Versioned"),
                  prototype = prototype(
                  new("Versioned", versions = c(PAHD = "0.1.0"))))

##' Writes a simple template in dcf format (like an R package
##' DESCRIPTION file) that, once completed (see
##' \code{ProteomicsAnnotationHub()} for details), can be imported
##' with \code{\link{readPahdFiles}} or directly processed with
##' \code{\link{PAHD}}. Note that these cdf files support comments (as
##' opposed to DESCRIPTION files). Lines starting with \code{#} will
##' be removed when parsed by \code{\link{readPahdFiles}}.
##'
##' @title Write a ProteomicsAnnotationHubData template
##' 
##' @param filename The name of the file to write the template
##'     in. Default is \code{""}, i.e. write output to the console.
##' 
##' @return Use for its side effect of preparing a annotation
##'     template.
##' @author Laurent Gatto <lg390@cam.ac.uk>
##' @examples
##' writePahdTemplate()
writePahdTemplate<- function(filename = "") {
    x <- c(Title = "A short title (one line)",
           Description = "A longer description",
           SourceType = "FASTA, mzTab, mzid, mzML, ... (only one).",
           Recipe = "see ProteomicsAnnotationHubData() for details",
           RDataPath = "Path to the file (on destination resource).",
           Location_Prefix = "Location of final file. Either S3 or PRIDE.",
           SourceUrl = "Location of source file. Either S3 or PRIDE.",
           Species = "Genus species",
           TaxonomyId = "Search in http://www.ncbi.nlm.nih.gov/taxonomy",
           File = "Data file name",
           DataProvider = "Orignal data provider, such as PRIDE.",
           Maintainer = "Your name <you@email.edu>",
           RDataClass = "Class of file served through AnnotationHub.",
           DispatchClass = "Dispatch class.",
           Tags = "Useful tags. ")
    write.dcf(t(as.matrix(x)), file = filename)
    message("See ProteomicsAnnotationHubData() for details.")
}

##' Reads one or multiple ProteomicsAnnotationHubData dcf files into a
##' \code{matrix} that can be processed with
##' \code{\link{PAHD}}. Commnent lines starting with \code{#} will be
##' removed. See \code{ProteomicsAnnotationDataHub()} for details.
##'
##' @title Reads one or multiple PAHD template files
##' 
##' @param file A \code{character} with one of multiple file names.
##' 
##' @return A \code{matrix} containing 
##' @author Laurent Gatto
##' @examples
##' ## example file for the PXD000001 data
##' f <- list.files(system.file("extdata", package = "ProteomicsAnnotationHubData"),
##'                 full.names = TRUE, pattern = "PXD000001.dcf")
##' readPahdFiles(f)
readPahdFiles <- function(file) {
    temp <- tempfile()
    on.exit({
        unlink(temp)
    })
    ## want to support comments, so we first read the lines one by
    ## one, remove those starting with '^#' and then write the lines
    ## in a temporary file    
    x <- lapply(file, readLines)
    x <- lapply(x, function(.x) .x[!grepl("^#", .x)])    
    x <- lapply(x, writeLines, temp)
    x <- read.dcf(temp)
    x[x == ""] <- NA_character_
    x[, "Description"] <- gsub("\n", " ", x[, "Description"])
    x
}

##' Reads ProteomicsAnnotationHubData dcf files and prepares them for
##' inclusion into AnnotationHub. See
##' \code{ProteomicsAnnotationDataHub{}} for details and an example.
##'
##' Note: Current limitation is that all the files are expected to
##' reside in a single resource directory.
##'
##' @title Prepare data for inclusion into AnnotationHub
##' @param x One of mulitple ProteomicsAnnotationHubData dcf files.
##' @param resourceDir A \code{character} containing the directory
##'     holding the files (for instance PRIDE). If missing, will be
##'     inferred from the first \code{RDataPath} field of \code{x}.
##' @return A \code{list} of \code{PAHD} objects that can be used to
##'     prepare and submit data to AnnotationHub. See
##'     \code{ProteomicsAnnotationHub()} for details.
##' @author Laurent Gatto
##' ## example file for the PXD000001 data
##' f <- list.files(system.file("extdata", package = "ProteomicsAnnotationHubData"),
##'                 full.names = TRUE)
##' PXD000001 <- PAHD(f)
##' length(PXD000001)
##' PXD000001[[1]]
PAHD <- function(x, resourceDir) {
    if (all(is.character(x)) & all(file.exists(x)))
        x <- readPahdFiles(x)
    ## else, we assume its a matrix as returned by readPahdFiles
    if (missing(resourceDir))
        resourceDir <- paste0(dirname(x[1, "RDataPath"]), "/")
        
    ans <- apply(x, 1,
                 function(.x) {
                     .x <- as.list(.x)
                     .x$SourceUrl <- updateUrlLocation(.x$SourceUrl)
                     .x$Location_Prefix <- updateUrlLocation(.x$Location_Prefix)
                     .x$TaxonomyId <- as.integer(.x$TaxonomyId)
                     .x <- addSourceUrlVersion(.x, resourceDir)
                     stopifnot(.x$DataProviders %in% names(ProteomicsAnnotationHubDataProviders))
                     .x$File <- NULL
                     do.call(.PAHD, .x)
                 })
    ans
}
