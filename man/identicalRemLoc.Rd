% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{identicalRemLoc}
\alias{identicalRemLoc}
\title{Are the remote and local instances identical}
\usage{
identicalRemLoc(rem, loc)
}
\arguments{
\item{rem}{An instance of class \code{AnnotationHub}}

\item{loc}{An instance of class \code{AnnotationHubMetadata}}
}
\value{
A \code{logical}
}
\description{
This function compares the metadata of a remote object \code{rem}
available on AnnotationHub and a local \code{PAHD} object. If
these are identical, \code{TRUE} is returned, \code{FALSE}
otherwise.
}

