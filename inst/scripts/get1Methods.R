setClass("mzRpwizResource", contains="AnnotationHubResource")
setMethod(".get1", "mzRpwizResource",
          function(x, ...) {
              .require("mzR")
              yy <- cache(.hub(x))
              openMSfile(yy, backend = "pwiz")
          })

## For MSnSet instances that are made available as is
setClass("MSnSetResource", contains="RdaResource")

setClass("mzTabResource", contains="RdaResource")
setMethod(".get1", "MSnSetResource",
          function(x, ...) {
              .require("MSnbase")
              yy <- cache(.hub(x))
              load(yy) 
          })

setClass("mzRidentResource", contains="AnnotationHubResource")
setMethod(".get1", "mzRidentResource",
          function(x, ...) {
              .require("mzR")
              yy <- cache(.hub(x))
              openIDfile(yy)
          })
          
setClass("MSnSetResource", contains="AnnotationHubResource")
setMethod(".get1", "MSnSetResource",
    function(x, ...)
{
    yy <- cache(.hub(x))
    read.delim(yy, skip=10)
})

setClass("AAStringSetResource", contains="AnnotationHubResource")
setMethod(".get1", "AAStringSetResource",
          function(x, ...) {
              .require("Biostrings")
              yy <- cache(.hub(x))
              readAAStringSet(yy)
          })
