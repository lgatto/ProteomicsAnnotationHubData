% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{makeAnnotationHubMetadata}
\alias{makeAnnotationHubMetadata}
\title{Make an AnnotationHubMeta resource}
\usage{
makeAnnotationHubMetadata(x, resource = proteomicsAnnotationHubDataResources)
}
\arguments{
\item{x}{A list of \code{PAHD} instances.}

\item{resource}{A \code{character} of length 1 with the desired
resource. See \code{proteomicsAnnotationHubDataResources} for
a list of available resourcs.}
}
\value{
A list of \code{PAHD} instances, matching \code{resource}.
}
\description{
Takes a list of \code{PAHD} instances and returns a subset
matching the requested resource.
}

