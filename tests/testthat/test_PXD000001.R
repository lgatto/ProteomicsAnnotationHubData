context("Testing PXD000001 metadata")

## Retrive the objects from AH and check their metadata against the
## locally stored objects

locfls <- dir(system.file("extdata", package = "ProteomicsAnnotationHubData"),
              full.names = TRUE)

test_that("PXD000001Fasta", {
    loc <- load(locfls[grep("Fasta", locfls)])
})

test_that("PXD000001MSnSet", {
})

test_that("PXD000001MzML", {
})

test_that("PXD000001MzID", {
})
