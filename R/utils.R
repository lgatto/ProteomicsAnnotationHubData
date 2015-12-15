## less typing
AnnotationHubMetadata <- AnnotationHubData:::AnnotationHubMetadata
.expandLine <- AnnotationHubData:::.expandLine
.amazonBaseUrl <- AnnotationHubData:::.amazonBaseUrl

.prideBaseUrl <- "ftp://ftp.pride.ebi.ac.uk/"

.ftpFileInfo2 <- function (url, filename, tag) {
    firsturl <- ifelse(length(url) > 1, url[1], url)
    curlHandle <- curl::new_handle()
    curl::handle_setopt(curlHandle, dirlistonly = TRUE)
    allurls <- lapply(url, function(ul) {
        ## .ftpFileInfo does not work for files on AHS3. See
        ## https://github.com/lgatto/ProteomicsAnnotationHubData/issues/8
        ## for details. We need to set the SourceUrl manually.
        if (grepl("s3.amazonaws.com", ul))
            return(paste0(url, filename))
        con <- curl::curl(ul, "r")
        txt <- read.table(con, stringsAsFactors = FALSE, fill = TRUE)
        close(con)
        df2 <- txt[[9]]
        df2 <- df2[grep(paste0(filename, "$"), df2)]
        drop <- grepl("00-", df2)
        df2 <- df2[!drop]
        paste0(ul, df2)
    })
    allurls <- unlist(allurls)
    curl::handle_reset(curlHandle)
    df <- AnnotationHubData:::.httrFileInfo(allurls, verbose = TRUE)
    base::cbind(df, genome = tag, stringsAsFactors = FALSE)
}

ProteomicsAnnotationHubDataProviders <-
    list(PRIDE = c(name = "PRIDE", baseUrl = .prideBaseUrl),
         AHS3 = c(name = "AHS3", baseUrl = .amazonBaseUrl))

ProteomicsAnnotationHubDataTags <-
    c("Proteomics",
      "TMT6", "TMT10", "iTRAQ4", "iTRAQ8",
      "LFQ", "SC", "SILAC",
      "PMID:1234567",
      "Instrument name")

##' @title Validity of an AH metadata list
##' @param x A list of metadata fields.
##' @param n The expected number of AH data objects to be documented.
##' @return \code{NULL}, if tested statements are
##'     \code{TRUE}. Otherwise throws an error.
checkMetaDataList <- function(x, n) {
    stopifnot(lengths(x) == n)
    stopifnot(x$DataProvider %in% names(ProteomicsAnnotationHubDataProviders))
    stopifnot(anyDuplicated(names(x)) == 0)
}

##' @title Fix length of metadata fields
##' @param x A list of metadata fields
##' @param n The expected number of AH data objects to be documented.
##' @return The updated and valid list of metadata fields.
fixMetaDataList <- function(x, n) {
    for (i in 1:length(x)) {
        if (length(x[[i]]) == 1)
            x[[i]] <- rep(x[[i]], n)
    }
    checkMetaDataList(x, 4)
    x
}

##' @title Adds the SourceUrl and SourceVersion fields
##' @param x A list of metadata fields, containing a FullUrl field.
##' @return Update list of metadat fields
addSourceUrlVersion <- function(x) {
    x$FullUrl <- paste0(x$SourceBaseUrl, .prideDir)
    ## .ftpFileInfo does not work for files on AHS3. See
    ## https://github.com/lgatto/ProteomicsAnnotationHubData/issues/8
    ## for details. We need to set the SourceUrl manually in
    ## ProteomicsAnnotationHubData.ftpFileInfo2 (rather that using
    ## AnnotationHubData:::.ftpFileinfo)
    flInfo <- Map(.ftpFileInfo2,
                  url = x$FullUrl,
                  filename = x$File,
                  tag = NA_character_)
    flInfo <- do.call(rbind, flInfo)
    flInfo$date <- as.character(flInfo$date)
    x$SourceUrl <- flInfo[, 1]
    x$SourceVersion <- flInfo[, 2]
    x
}

##' @title Order AH metadata by \code{RDataClass}
##' @param x A list of metadata fields
##' @return Ordered list of metadata fields.
orderMetaDataList <- function(x) {
    o <- order(x[["RDataClass"]])
    lapply(x, function(xx) xx[o])
}


##' @title Create a list of AH resources of same type
##' @param x A valid list of metadata fields.
##' @param resource What type of resource
##' @return A list of AnnotationHubMetadata of same type
makeAnnotationHubMetadata <- function(x,
                                      resource = c("FASTA",
                                                   "mzTab",
                                                   "mzid",
                                                   "mzML")) {
    resource <- match.arg(resource)
    i <- grep(resource, x$SourceType)
    ans <- vector("list", length = length(i))
    j <- 1
    for (ii in i) {
        ans[[j]] <-
                    AnnotationHubMetadata(
                        Title = x$Title[ii],
                        Description = x$Description[ii],
                        SourceType = x$SourceType[ii],
                        SourceUrl = x$SourceUrl[ii],
                        SourceVersion = x$SourceVersion[ii],
                        Species = x$Species[ii],
                        Genome = x$Genome[ii],
                        TaxonomyId = x$TaxonomyId[ii],
                        RDataPath = x$RDataPath[ii],
                        DataProvider = x$DataProvider[ii],
                        Maintainer = x$Maintainer[ii],
                        RDataClass =  x$RDataClass[ii],
                        BiocVersion  =  BiocInstaller::biocVersion(),
                        RDataDateAdded = Sys.time(),
                        Location_Prefix = x$Location_Prefix[ii],
                        Recipe = x$Recipe[ii],
                        DispatchClass = x$DispatchClass[ii],
                        Tags = x$Tags[[ii]])
        j <- j + 1
    }
    ans
}

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
