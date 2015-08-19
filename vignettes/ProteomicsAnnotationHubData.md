---
title: "Proteomics Data in Annotation Hub"
output:
  BiocStyle::html_document:
     toc: false
     toc_depth: 1
vignette: >
  % \VignetteIndexEntry{Proteomics Data in Annotation Hub}
  % \VignetteEngine{knitr::rmarkdown}
  % \VignetteKeyword{proteomics, mass spectrometry, data}
  % \VignettePackage{ProteomicsAnnotationHubData}
---



```
## Warning: package 'BiocStyle' was built under R version 3.3.0
```

<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
  document.querySelector("h1").className = "title";
});
</script>
<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function() {
  var links = document.links;  
  for (var i = 0, linksLength = links.length; i < linksLength; i++)
    if (links[i].hostname != window.location.hostname)
      links[i].target = '_blank';
});
</script>
<style type="text/css" scoped>
body, td {
   font-family: sans-serif;
   background-color: white;
   font-size: 13px;
}

body {
  max-width: 800px;
  margin: 0 auto;
  padding: 1em 1em 2em;
  line-height: 20px;
}

/* Table of contents style */

div#TOC li {
    list-style:none;
    background-image:none;
    background-repeat:none;
    background-position:0;
}

/* element spacing */

p, pre { 
  margin: 0em 0em 1em;
}

/* center images and tables */
img, table {
  margin: 0em auto 1em;
}

p {
  text-align: justify;
}

tt, code, pre {
   font-family: 'DejaVu Sans Mono', 'Droid Sans Mono', 'Lucida Console', Consolas, Monaco, monospace;
}

h1, h2, h3, h4, h5, h6 { 
  font-family: Helvetica, Arial, sans-serif;
  margin: 1.2em 0em 0.6em 0em;
  font-weight: bold;
}

h1.title {
  font-size: 250%;
  font-weight: normal;
  color: #87b13f;
  line-height: 1.1em;
  margin-top: 0px;
  border-bottom: 0px;
}

h1 {
  font-size: 160%;
  font-weight: normal;
  line-height: 1.4em;
  border-bottom: 1px #1a81c2 solid;
}

h2 {
  font-size: 130%;  
}

h1, h2, h3 {
  color: #1a81c2;
}

h3, h4, h5, h6 {
  font-size:115%;
} /* not expecting to dive deeper than four levels on a single page */

/* links are simply blue, hovering slightly less blue */
a { color: #1a81c2; }
a:active { outline: none; }
a:visited { color: #1a81c2; }
a:hover { color: #4c94c2; }

pre, img {
  max-width: 100%;
  display: block;
}

pre {
  border: 0px none;
  background-color: #F8F8F8;
  white-space: pre;
  overflow-x: auto;
}

pre code {
  border: 1px #aaa dashed;
  background-color: white;
  display: block;
  padding: 1em;  
  color: #111;
  overflow-x: inherit;
}

/* markdown v1 */
pre code[class] {
  background-color: inherit;
}

/* markdown v2 */
pre[class] code {
  background-color: inherit;
}

/* formatting of inline code */
code { 
  background-color: transparent;
  color: #87b13f;
  font-size: 92%;
}

/* formatting of tables */

table, td, th {
  border: none;
  padding: 0 0.5em;
}

/* alternating row colors */
tbody tr:nth-child(odd) td {
  background-color: #F8F8F8;
}

blockquote {
   color:#666666;
   margin:0;
   padding-left: 1em;
   border-left: 0.5em #EEE solid;
}

hr {
   height: 0px;
   border-bottom: none;
   border-top-width: thin;
   border-top-style: dotted;
   border-top-color: #999999;
}

span.header-section-number, span.toc-section-number {
  padding-right: 1em;
}

@media print {
   * {
      background: transparent !important;
      color: black !important;
      filter:none !important;
      -ms-filter: none !important;
   }

   body {
      font-size:12pt;
      max-width:100%;
   }

   a, a:visited {
      text-decoration: underline;
   }

   hr {
      visibility: hidden;
      page-break-before: always;
   }

   pre, blockquote {
      padding-right: 1em;
      page-break-inside: avoid;
   }

   tr, img {
      page-break-inside: avoid;
   }

   img {
      max-width: 100% !important;
   }

   @page :left {
      margin: 15mm 20mm 15mm 10mm;
   }

   @page :right {
      margin: 15mm 10mm 15mm 20mm;
   }

   p, h2, h3 {
      orphans: 3; widows: 3;
   }

   h2, h3 {
      page-break-after: avoid;
   }
}
</style>



**Package**: *[ProteomicsAnnotationHubData](http://bioconductor.org/packages/release/bioc/html/ProteomicsAnnotationHubData.html)*<br />
**Authors**: Gatto Laurent [aut, cre],
  Sonali Arora [aut]<br />
**Modified:** 2015-08-19 23:54:48<br />
**Compiled**: Thu Aug 20 00:03:07 2015

# Introduction

About *[AnnotationHub](http://bioconductor.org/packages/release/bioc/html/AnnotationHub.html)*:

> This package provides a client for the Bioconductor AnnotationHub
> web resource. The AnnotationHub web resource provides a central
> location where genomic files (e.g., VCF, bed, wig) and other
> resources from standard locations (e.g., UCSC, Ensembl) can be
> discovered. The resource includes metadata about each resource,
> e.g., a textual description, tags, and date of modification. The
> client creates and manages a local cache of files retrieved by the
> user, helping with quick and reproducible access.

The goal of this project is to expand this functionality to mass
spectrometry and proteomics.


See the `AnnotationHub`'s
[How-To's](http://bioconductor.org/packages/devel/bioc/vignettes/AnnotationHub/inst/doc/AnnotationHub-HOWTO.html)
and
[Access the AnnotationHub Web Service](http://bioconductor.org/packages/devel/bioc/vignettes/AnnotationHub/inst/doc/AnnotationHub.html)
vignettes for a description on how to use it.

## Accessing proteomics data {-}


```r
library("AnnotationHub")
ah <- AnnotationHub()
```

```
## snapshotDate(): 2015-08-17
```

```r
ah
```

```
## AnnotationHub with 35372 records
## # snapshotDate(): 2015-08-17 
## # $dataprovider: BroadInstitute, UCSC, Ensembl, ftp://ftp.ncbi.nlm.nih....
## # $species: Homo sapiens, Mus musculus, Bos taurus, Pan troglodytes, Da...
## # $rdataclass: GRanges, BigWigFile, FaFile, ChainFile, OrgDb, Inparanoi...
## # additional mcols(): taxonomyid, genome, description, tags,
## #   sourceurl, sourcetype 
## # retrieve records with, e.g., 'object[["AH2"]]' 
## 
##             title                                               
##   AH2     | Ailuropoda_melanoleuca.ailMel1.69.dna.toplevel.fa   
##   AH3     | Ailuropoda_melanoleuca.ailMel1.69.dna_rm.toplevel.fa
##   AH4     | Ailuropoda_melanoleuca.ailMel1.69.dna_sm.toplevel.fa
##   AH5     | Ailuropoda_melanoleuca.ailMel1.69.ncrna.fa          
##   AH6     | Ailuropoda_melanoleuca.ailMel1.69.pep.all.fa        
##   ...       ...                                                 
##   AH49568 | gencode.vM6.chr_patch_hapl_scaff.transcripts.fa.gz  
##   AH49569 | gencode.vM6.lncRNA_transcripts.fa.gz                
##   AH49570 | gencode.vM6.pc_transcripts.fa.gz                    
##   AH49571 | gencode.vM6.pc_translations.fa.gz                   
##   AH49572 | gencode.vM6.transcripts.fa.gz
```

We can extract the entries that originate from the PRIDE database:


```r
ah[ah$dataprovider == "PRIDE"]
```

```
## AnnotationHub with 4 records
## # snapshotDate(): 2015-08-17 
## # $dataprovider: PRIDE
## # $species: Erwinia carotovora
## # $rdataclass: AAStringSet, MSnSet, mzRident, mzRpwiz
## # additional mcols(): taxonomyid, genome, description, tags,
## #   sourceurl, sourcetype 
## # retrieve records with, e.g., 'object[["AH49006"]]' 
## 
##             title                                                         
##   AH49006 | PXD000001: Erwinia carotovora and spiked-in protein fasta file
##   AH49007 | PXD000001: Peptide-level quantitation data                    
##   AH49008 | PXD000001: raw mass spectrometry data                         
##   AH49009 | PXD000001: MS-GF+ identiciation data
```

Or those of a specific project


```r
ah[grep("PXD000001", ah$title)]
```

```
## AnnotationHub with 4 records
## # snapshotDate(): 2015-08-17 
## # $dataprovider: PRIDE
## # $species: Erwinia carotovora
## # $rdataclass: AAStringSet, MSnSet, mzRident, mzRpwiz
## # additional mcols(): taxonomyid, genome, description, tags,
## #   sourceurl, sourcetype 
## # retrieve records with, e.g., 'object[["AH49006"]]' 
## 
##             title                                                         
##   AH49006 | PXD000001: Erwinia carotovora and spiked-in protein fasta file
##   AH49007 | PXD000001: Peptide-level quantitation data                    
##   AH49008 | PXD000001: raw mass spectrometry data                         
##   AH49009 | PXD000001: MS-GF+ identiciation data
```

To see the metadata of a specific entry, we use its AnnotationHub
entry number inside single `[`


```r
ah["AH49008"]
```

```
## AnnotationHub with 1 record
## # snapshotDate(): 2015-08-17 
## # names(): AH49008
## # $dataprovider: PRIDE
## # $species: Erwinia carotovora
## # $rdataclass: mzRpwiz
## # $title: PXD000001: raw mass spectrometry data
## # $description: Four human TMT spliked-in proteins in an Erwinia caroto...
## # $taxonomyid: 554
## # $genome: NA
## # $sourcetype: mzML
## # $sourceurl: ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2012/03/PXD0...
## # $sourcelastmodifieddate: NA
## # $sourcesize: NA
## # $tags: Proteomics, TMT6, LTQ Orbitrap Velos, PMID:23692960 
## # retrieve record with 'object[["AH49008"]]'
```

To access the actual data, raw mass spectrometry data in this case, we
double the `[[`


```r
library("mzR")
rw <- ah[["AH49008"]]
rw
```

```
## Mass Spectrometry file handle.
## Filename:  55314 
## Number of scans:  7534
```

In this case, we have an instance of class mzRpwiz,
that can be processed as anticipated


```r
plot(peaks(rw, 1), type = "h", xlab = "M/Z", ylab = "Intensity")
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6-1.png) 

In the short demonstration above, we had **direct** and
**standardised** access to the raw data, without a need to manually
open this raw data or worry about the file format. The data was
prepared and converted into a **standard Bioconductor data types** for
immediate consumption by the user. This is also valid for other
relevant data types such as identification results, fasta files or
protein of peptide quantitation data.

# Available datasets

To list all available proteomics datasets, one can query
`AnnotationHub`, as described above, or using the following variable
defined in the `ProteomicsAnnotationHubData` package:


```r
library("ProteomicsAnnotationHubData")
availableProteomicsAnnotationHubData
```

```
## [1] "PXD000001"
```

## PXD000001

Description

> Four human TMT spliked-in proteins in an Erwinia carotovora
> background. Expected reporter ion ratios: Erwinia peptides:
> 1:1:1:1:1:1; Enolase spike (sp|P00924|ENO1_YEAST):
> 10:5:2.5:1:2.5:10; BSA spike (sp|P02769|ALBU_BOVIN): 1:2.5:5:10:5:1;
> PhosB spike (sp|P00489|PYGM_RABIT): 2:2:2:2:1:1; Cytochrome C spike
> (sp|P62894|CYC_BOVIN): 1:1:1:1:1:2.


Four data files from the PRIDE
[PXD000001](http://www.ebi.ac.uk/pride/archive/projects/PXD000001)
experiment are served through `AnnotationHub`.

1. The raw mass spectrometry data from the
   `TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01-20141210.mzML`
   file from the PRDIE ftp site, served as an `mzRpwiz` object, from
   the *[mzR](http://bioconductor.org/packages/release/bioc/html/mzR.html)* package.

2. The peptide-level quantitation data from the
   `F063721.dat-mztab.txt` file from the PRIDE ftp site, served as an
   `MSnSet` object, from the *[MSnbase](http://bioconductor.org/packages/release/bioc/html/MSnbase.html)* package.

3. The protein data base, via the `erwinia_carotovora.fasta` file from
	the PRIDE ftp server, served as a `AAStringSet` object, from the
	*[Biostrings](http://bioconductor.org/packages/release/bioc/html/Biostrings.html)* package.

4. The identification results, produced using the `MSGF+` search
   engine, served as a `mzRident` object, from the *[mzR](http://bioconductor.org/packages/release/bioc/html/mzR.html)*
   package.


# Data and metadata

This section describes how `ProteomicsAnnotationHubData` are described
and generated. See also the *[AnnotationHub](http://bioconductor.org/packages/release/bioc/html/AnnotationHub.html)* package for
additional documentation.

## Annotation

### Updates {-}

To suggest updates and/or new mass spectrometry and/or proteomics
data, please post your suggestions/request on the
[Bioconductor support site](https://support.bioconductor.org/) or open
a
[github issue](https://github.com/lgatto/ProteomicsAnnotationHubData/issues).
Contributions can also be made to the
[package github repository](https://github.com/lgatto/ProteomicsAnnotationHubData).

### Title {-}

The title of a file should always be prefixed with its experiment
identifier, such as

```
PXD000001: Erwinia carotovora and spiked-in protein fasta file
```
```
PXD000001: Peptide-level quantitation data
```

### Tags {-}

A list of suggested tags is shown below. These suggestions will be
updated and completed over time.


```
##  [1] "Proteomics"      "TMT6"            "TMT10"          
##  [4] "iTRAQ4"          "iTRAQ8"          "LFQ"            
##  [7] "SC"              "SILAC"           "PMID:1234567"   
## [10] "Instrument name"
```

### Providers  {-}

A list of predefined/tested providers. 


|name  |baseUrl                                |
|:-----|:--------------------------------------|
|PRIDE |ftp://ftp.pride.ebi.ac.uk/             |
|AHS3  |http://s3.amazonaws.com/annotationhub/ |

### Source types {-}

|-------------------|---------|---------|-----------|--------------|--------|
| **SourceType**    |  mzML   |   mzTab |   mzid    |      FASTA   | MSnSet |
| **DispatchClass** | mzRpwiz |  MSnSet |  mzRident |  AAStringSet | MSnSet |
| **RDataClass**    | mzRpwiz |  MSnSet |  mzRident |  AAStringSet | MSnSet |

## Data location and associated metadata

### Overview {-}

The data accessed through the *[AnnotationHub](http://bioconductor.org/packages/release/bioc/html/AnnotationHub.html)*
infrastructure exists, in different forms, in different
locations. These locations can be the user's computer, the
AnnotationHub Amazon S3 instance and the original data
provider. Multiple scenarios are can occur:

1. The data originates from the provider's public repository. It is
   directly server to the user, from that third-party server, with
   possible local processing/coercion and made accessible as a
   Bioconductor data object.

2. The data originates from the provider's public repository. However,
   conversion to a Bioconductor data object is time-consuming or it is
   anticipated that this would be repeated many times. The data is
   therefor copied, processed and stored on the AnnotationHub Amazon
   S3 instance and server from there upon request.

3. The original file is not available from a data provider, is stored
   on the AnnotationHub Amazon S3 instance and, possibly
   pre-processed. Upon request, it is served to the user.

### Definitions {-}

- The `Recipe` is a short function, typically named
  `NameOfDataOrigformatToFinalformat`, that generally converts the
  original data into on compatible with R/Bioconductor or enable to
  read the data directly using a special data accessor.

    For example, for some `fasta` files, the recipe function uses the
    `Rsamtools::indexFa` function to create an index file without
    converting the original file. Similarly, raw mass-spectrometry
    files are not converted into objects *per se*, but an accessor
    object is produced to extract data directly from the data file.

- `Location_Prefix` is either `.amazonBaseUrl`, when the file to be
  loaded/read by the user exists on the AH Amazon S3 instance, or
  `.prideBaseUrl` when it lives on the PRIDE ftp server.

- `SourceUrl` is the full location of the original file. This is
  generally the third-party server, but not necessarily.

- `RDataPath` is the path and filename of the file to be read into R
  and provided to the user. This field does not contain the server
  address `.prideBaseUrl` or `.amazonBaseUrl` (see `Location_Prefix`).

- The metadata list, used to create the `AnnotationHubResources` also
  uses a `SourceBaseUrl`, which is the full url minus file name (that
  is in `File`) of the original file. Used to construct `SourceUrl`.


### Examples {-}

Refering back to the scenarios described above

#### Scenario 1 {-}

Files that are downloaded from the third-party resource, in our case
PRIDE, and loaded directly into R without any pre-processing:

- the `Recipe` argument **must be** `NA`.
- the `Location_Prefix` should be the `.prideBaseUrl`.
- the `RDdataPath` should be `sub(.prideBaseUrl, "", SourceUrl)`
- the `SourceUrl` should be the actual full url on third-party server.

If the data is pre-processed, a `Recipe` must be provided.

An example from the `PXD000001` data set is the raw `mzML` file, which
is directly downloaded from the PRIDE server and read into R as an
`mzRpwiz` object:

```
SourceType: mzML
RDataClass: mzRpwiz
Recipe: NA
Location_Prefix: ftp://ftp.pride.ebi.ac.uk/
RDataPath: pride/data/archive/2012/03/PXD000001/TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01-20141210.mzML
SourceUrl: ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2012/03/PXD000001/TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01-20141210.mzML
```

#### Scenario 2 {-}

Files that need to be downloaded from a third-party provider such as
the PRIDE server, pre-processed and the pre-processed product is
stored on AnnotationHub Amazon s3 machine. The user directly gets the
object from Amazon S3 instance:

- the `Recipe` argument **should not be** `NA`.
- the `Location_Prefix` **should be** the `.amazonBaseUrl`.
- the `RDataPath` should correspond to the directory structure after
  `.amazonBaseUrl` on the Amazon s3 instance. Typically, the directory
  structure on the Amazon S3 instance mimics the directory structure
  on the original server.
- the `SourceUrl` should be the actual url on third-party server.

An example from the `PXD000001` data set is the `fasta` file. It
originates from the
[PRIDE ftp server](ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2012/03/PXD000001/),
but is processed into and `AAStringSet` and stored/server on the
AnnotationHub Amazon S3 instance.

```
SourceType: FASTA
RDataClass: AAStringSet
Recipe: ProteomicsAnnotationHubData:::PXD000001FastaToAAStringSet
Location_Prefix: http://s3.amazonaws.com/annotationhub/
RDataPath: pride/data/archive/2012/03/PXD000001/erwinia_carotovora.rda
SourceUrl: ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2012/03/PXD000001/erwinia_carotovora.fasta
```

Another example is the `mzTab` file with peptide-level quantitation
data, that is served from the Amazon instance as an `MSnSet` object.

```
SourceType: mzTab
RDataClass: MSnSet
Recipe: ProteomicsAnnotationHubData:::PXD000001MzTabToMSnSet
Location_Prefix: http://s3.amazonaws.com/annotationhub/
RDataPath: pride/data/archive/2012/03/PXD000001/F063721.dat-MSnSet.rda
SourceUrl: ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2012/03/PXD000001/F063721.dat-mztab.txt
```

#### Scenario 3 {-}

The original data file and the Bioconductor data object are stored on
the AnnotationHub Amazon S3 instance and directly served to the user
upon request.

An example from the `PXD000001` data set is the `mzid` file, which is
not available from the PRIDE ftp server (only a Macot `dat` file is
provided).

```
SourceType: mzid
RDataClass: mzRident
Recipe: NA
Location_Prefix: http://s3.amazonaws.com/annotationhub/
RDataPath: pride/data/archive/2012/03/PXD000001/TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01-20141210.mzid
SourceUrl: http://s3.amazonaws.com/annotationhub/pride/data/archive/2012/03/PXD000001/TMT_Erwinia_1uLSike_Top10HCD_isol2_45stepped_60min_01-20141210.mzid
```

### Preparer functions {-}

Preparer functions and recipes are only required if the `rda` file is
prepared on the `AnnotationHub` Amazon S3 instance.

## Testing

### Generic tests {-}

**TODO**, when generating the AH data

- Check that `SourceType`, `DispatchClass` and `RDataClass` match.
- Checking file types that have a base URL on amazon or PRIDE.

### Experiment/data unit tests {-}

When new data/experiments or even file types are added, the procedure
to add new `AnnotationHub` items will be streamlined, revised,
simplified and hopefully automated. To make sure that any of these
updates do not alter the format/annotation, a set of
experiment-specific unit tests are set up, that compare the metadata
created in this package and the metadata extracted from
`AnnotationHub`.


See for example `./tests/testthat/test_PXD000001.R`.
