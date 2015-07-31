context("Testing PXD000001 metadata")

## Retrive the objects from AH and check their metadata against the
## locally stored objects

locfls <- dir(system.file("extdata", package = "ProteomicsAnnotationHubData"),
              full.names = TRUE)

test_that("PXD000001Fasta", {
    loc <- readRDS(locfls[grep("Fasta", locfls)])[[1]]
})

test_that("PXD000001MSnSet", {
    loc <- readRDS(locfls[grep("MSnSet", locfls)])[[1]]
})

test_that("PXD000001MzML", {
    loc <- readRDS(locfls[grep("MzML", locfls)])[[1]]
})

test_that("PXD000001MzID", {
    loc <- readRDS(locfls[grep("MzID", locfls)])[[1]]
})
