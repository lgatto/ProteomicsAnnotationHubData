context("Testing PXD000001 metadata")

ah <- AnnotationHub::AnnotationHub()

test_that("PXD000001Fasta", {
    loc <- ProteomicsAnnotationHubData:::PXD000001Fasta[[1]]
    rem <- ah["AH49006"]
    expect_true(identicalRemLoc(rem, loc))
})

test_that("PXD000001MSnSet", {
    loc <- ProteomicsAnnotationHubData:::PXD000001MSnSet[[1]]
    rem <- ah["AH49007"]
    expect_true(identicalRemLoc(rem, loc))    
})

test_that("PXD000001MzML", {
    loc <- ProteomicsAnnotationHubData:::PXD000001MzML[[1]]
    rem <- ah["AH49008"]
    expect_true(identicalRemLoc(rem, loc))
})

test_that("PXD000001MzID", {
    loc <- ProteomicsAnnotationHubData:::PXD000001MzID[[1]]
    rem <- ah["AH49009"]
    expect_true(identicalRemLoc(rem, loc))
})
