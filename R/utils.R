## Replaces S3 and PRIDE with URLs
updateUrlLocation <- function(x) {
          x <- match.arg(x, c("S3", "PRIDE"))
          if (x == "S3") return(.amazonBaseUrl)
          if (x == "PRIDE") return(.prideBaseUrl)
}

.ftpFileInfo2 <- function (url, filename, tag) {
    firsturl <- ifelse(length(url) > 1, url[1], url)
    allurls <- lapply(url, function(ul) {
        ## .ftpFileInfo does not work for files on AHS3. See
        ## https://github.com/lgatto/ProteomicsAnnotationHubData/issues/8
        ## for details. We need to set the SourceUrl manually.
        if (grepl("s3.amazonaws.com", ul))
            return(paste0(url, filename))
        txt <- RCurl::getURL(ul, ftp.use.epsv = FALSE, dirlistonly = TRUE)
        txt <- strsplit(txt, "\r*\n")[[1]]
        fn <- txt[match(filename, txt)]
        if (is.na(fn)) stop("Could not match filename on remote directory!")
        paste0(ul, fn)
    })
    allurls <- unlist(allurls)
    df <- AnnotationHubData:::.httrFileInfo(allurls, verbose = TRUE)
    base::cbind(df, genome = tag, stringsAsFactors = FALSE)
}

addSourceUrlVersion <- function(x, .prideDir) {
    FullUrl <- paste0(x$SourceUrl, .prideDir)
    ## .ftpFileInfo does not work for files on AHS3. See
    ## https://github.com/lgatto/ProteomicsAnnotationHubData/issues/8
    ## for details. We need to set the SourceUrl manually in
    ## ProteomicsAnnotationHubData.ftpFileInfo2 (rather that using
    ## AnnotationHubData:::.ftpFileinfo)
    flInfo <- Map(.ftpFileInfo2,
                  url = FullUrl,
                  filename = x$File,
                  tag = NA_character_)
    flInfo <- do.call(rbind, flInfo)
    flInfo$date <- as.character(flInfo$date)
    x$SourceUrl <- flInfo[, 1]
    x$SourceVersion <- flInfo[, 2]
    x
}

##' Takes a list of \code{PAHD} instances and returns a subset
##' matching the requested resource.
##'
##' @title Make an AnnotationHubMeta resource
##' @param x A list of \code{PAHD} instances.
##' @param resource A \code{character} of length 1 with the desired
##'     resource. See \code{proteomicsAnnotationHubDataResources} for
##'     a list of available resourcs.
##' @return A list of \code{PAHD} instances, matching \code{resource}.
makeAnnotationHubMetadata <- function(x,
                                      resource = proteomicsAnnotationHubDataResources) {
    resource <- match.arg(resource)
    i <- grep(resource, sapply(x, slot, "SourceType"))
    x[i]
}

##' This function compares the metadata of a remote object \code{rem}
##' available on AnnotationHub and a local \code{PAHD} object. If
##' these are identical, \code{TRUE} is returned, \code{FALSE}
##' otherwise.
##' 
##' @title Are the remote and local instances identical
##' @param rem An instance of class \code{AnnotationHub}
##' @param loc An instance of class \code{AnnotationHubMetadata}
##' @return A \code{logical}
identicalRemLoc <- function(rem, loc) {
    res <- TRUE
    if (!identical(rem$dataprovider, loc@DataProvider)) {
        warning("DataProviders are not identical", call. = FALSE)
        res <- FALSE
    }
    if (!identical(rem$description, loc@Description)) {
        warning("Descriptions are not identical", call. = FALSE)
        res <- FALSE
    }
    if (!identical(rem$genome, loc@Genome)) {
        warning("Genomes are not identical", call. = FALSE)
        res <- FALSE
    }
    if (!identical(rem$rdataclass, loc@RDataClass)) {
        warning("DataClasses are not identical", call. = FALSE)
        res <- FALSE
    }
    if (!identical(rem$sourcetype, loc@SourceType)) {
        warning("SourceTypes are not identical", call. = FALSE)
        res <- FALSE
    }
    if (!identical(rem$sourceurl, loc@SourceUrl)) {        
        warning("SourceUrls are not identical", call. = FALSE)
        res <- FALSE
    }
    if (!identical(rem$species, loc@Species)) {
        warning("Species are not identical", call. = FALSE)
        res <- FALSE
    }
    loctags <- paste(loc@Tags, collapse = ", ")
    if (!identical(rem$tags, loctags)) {        
        warning("Tags are not identical", call. = FALSE)
        res <- FALSE
    }
    if (!identical(rem$taxonomyid, loc@TaxonomyId)) {
        warning("TaxonomyIds are not identical", call. = FALSE)
        res <- FALSE
    }
    if (!identical(rem$title, loc@Title)) {
        warning("Titles are not identical", call. = FALSE)
        res <- FALSE
    }
    res
}
