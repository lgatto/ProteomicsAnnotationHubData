context("Testing PXD000001 metadata")

ah <- AnnotationHub::AnnotationHub()
fls <- list.files(system.file("extdata",
                              package = "ProteomicsAnnotationHubData"),
                  full.names = TRUE, pattern = "PXD000001.+\\.rda")

test_that("PXD000001Fasta", {
    load(grep("Fasta", fls, value = TRUE))
    loc <- PXD000001Fasta[[1]]
    rem <- ah["AH49006"]
    expect_true(identicalRemLoc(rem, loc))
})

test_that("PXD000001MSnSet", {
    load(grep("MSnSet", fls, value = TRUE))
    loc <- PXD000001MSnSet[[1]]
    rem <- ah["AH49007"]
    expect_true(identicalRemLoc(rem, loc))
})

test_that("PXD000001MzML", {
    load(grep("MzML", fls, value = TRUE))
    loc <- PXD000001MzML[[1]]
    rem <- ah["AH49008"]
    expect_true(identicalRemLoc(rem, loc))
})

test_that("PXD000001MzID", {
    load(grep("MzID", fls, value = TRUE))
    loc <- PXD000001MzID[[1]]
    rem <- ah["AH49009"]
    expect_true(identicalRemLoc(rem, loc))
})
