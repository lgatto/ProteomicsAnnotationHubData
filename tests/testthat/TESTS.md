# ProteomicsAnnotationHub Unit Tests

## Experiment/data tests

When new data/experiments or even file types will be added, the
procedure to add new AH items will be streamlined, revised, simplified
and hopefully automated. To make sure that any of these updates do not
alter the format/annotation, a set of experiment-specific unit tests
will be set up that will compare the metadata created in this package
and the metadata extracted from AH.

For this to work, I would like to move the calls up updateResources
inside the PXD000001.R file (and not save their output), so that the
relevant (list of) AnnotationHubMetadata objects lives in the
package's namespace. This would then allow me to implement the above
tests.

Qst for Sonlai: Is there a specific reason the call to updateResources
is in inst/scripts ans could not be moved in R, keeping metadataOnly
FALSE, of course). 
