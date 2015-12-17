.PAHD <- setClass("PAHD",
                  contains = "AnnotationHubMetadata")

##' .. content for \description{} (no empty lines) ..
##'
##' .. content for \details{} ..
##' @title
##' 
##' @param filename The name of the file to write the template
##'     in. Default is \code{""}, i.e. write output to the console.
##' 
##' @return Use for its side effect of preparing a annotation
##'     template.
##' @author Laurent Gatto <lg390@cam.ac.uk>
##' @examples
##' writePahdTemplate()
writePahdTemplate <- function(filename = "") {
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

##' .. content for \description{} (no empty lines) ..
##'
##' @title Reads one or multiple PAHD template files
##' 
##' @param file A \code{character} with one of multiple file names.
##' 
##' @return A \code{matrix} containing 
##' @author Laurent Gatto
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
    x
}


makePadhList <- function(x, .prideDir) {
    if (all(is.character(x)) & all(file.exists(x)))
        x <- readPahdFiles(x)
    ## else, we assume its a matrix as returned by readPahdFiles
    ans <- apply(x, 1,
                 function(.x) {
                     .x <- as.list(.x)
                     .x$SourceUrl <- updateUrlLocation(.x$SourceUrl)
                     .x$Location_Prefix <- updateUrlLocation(.x$Location_Prefix)
                     .x$TaxonomyId <- as.integer(.x$TaxonomyId)
                     .x <- addSourceUrlVersion(.x, .prideDir)
                     stopifnot(.x$DataProviders %in% names(ProteomicsAnnotationHubDataProviders))
                     .x$File <- NULL
                     do.call(.PAHD, .x)
                 })
    ans
}
