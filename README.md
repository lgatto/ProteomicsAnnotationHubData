---
title: `AnnotationHub` for proteomics
output:
  md_document:
    variant: markdown_github
---

<!-- README.md is generated from README.Rmd. Please edit that file -->


```
## Warning: package 'BiocStyle' was built under R version 3.3.0
```

The aim of this package is to offer access to mass spectrometry and
proteomics data throught the *[AnnotationHub](http://bioconductor.org/packages/release/bioc/html/AnnotationHub.html)*
infrastructure.




```r
library("AnnotationHub")
ah <- AnnotationHub()
#> snapshotDate(): 2015-08-17
ah
#> AnnotationHub with 35372 records
#> # snapshotDate(): 2015-08-17 
#> # $dataprovider: BroadInstitute, UCSC, Ensembl, ftp://ftp.ncbi.nlm.nih....
#> # $species: Homo sapiens, Mus musculus, Bos taurus, Pan troglodytes, Da...
#> # $rdataclass: GRanges, BigWigFile, FaFile, ChainFile, OrgDb, Inparanoi...
#> # additional mcols(): taxonomyid, genome, description, tags,
#> #   sourceurl, sourcetype 
#> # retrieve records with, e.g., 'object[["AH2"]]' 
#> 
#>             title                                               
#>   AH2     | Ailuropoda_melanoleuca.ailMel1.69.dna.toplevel.fa   
#>   AH3     | Ailuropoda_melanoleuca.ailMel1.69.dna_rm.toplevel.fa
#>   AH4     | Ailuropoda_melanoleuca.ailMel1.69.dna_sm.toplevel.fa
#>   AH5     | Ailuropoda_melanoleuca.ailMel1.69.ncrna.fa          
#>   AH6     | Ailuropoda_melanoleuca.ailMel1.69.pep.all.fa        
#>   ...       ...                                                 
#>   AH49568 | gencode.vM6.chr_patch_hapl_scaff.transcripts.fa.gz  
#>   AH49569 | gencode.vM6.lncRNA_transcripts.fa.gz                
#>   AH49570 | gencode.vM6.pc_transcripts.fa.gz                    
#>   AH49571 | gencode.vM6.pc_translations.fa.gz                   
#>   AH49572 | gencode.vM6.transcripts.fa.gz
```

We can extract the entries that originate from the PRIDE database:


```r
ah[ah$dataprovider == "PRIDE"]
#> AnnotationHub with 4 records
#> # snapshotDate(): 2015-08-17 
#> # $dataprovider: PRIDE
#> # $species: Erwinia carotovora
#> # $rdataclass: AAStringSet, MSnSet, mzRident, mzRpwiz
#> # additional mcols(): taxonomyid, genome, description, tags,
#> #   sourceurl, sourcetype 
#> # retrieve records with, e.g., 'object[["AH49006"]]' 
#> 
#>             title                                                         
#>   AH49006 | PXD000001: Erwinia carotovora and spiked-in protein fasta file
#>   AH49007 | PXD000001: Peptide-level quantitation data                    
#>   AH49008 | PXD000001: raw mass spectrometry data                         
#>   AH49009 | PXD000001: MS-GF+ identiciation data
```

Or those of a specific project


```r
ah[grep("PXD000001", ah$title)]
#> AnnotationHub with 4 records
#> # snapshotDate(): 2015-08-17 
#> # $dataprovider: PRIDE
#> # $species: Erwinia carotovora
#> # $rdataclass: AAStringSet, MSnSet, mzRident, mzRpwiz
#> # additional mcols(): taxonomyid, genome, description, tags,
#> #   sourceurl, sourcetype 
#> # retrieve records with, e.g., 'object[["AH49006"]]' 
#> 
#>             title                                                         
#>   AH49006 | PXD000001: Erwinia carotovora and spiked-in protein fasta file
#>   AH49007 | PXD000001: Peptide-level quantitation data                    
#>   AH49008 | PXD000001: raw mass spectrometry data                         
#>   AH49009 | PXD000001: MS-GF+ identiciation data
```

To see the metadata of a specific entry, we use its AnnotationHub
entry number inside single `[`


```r
ah["AH49008"]
#> AnnotationHub with 1 record
#> # snapshotDate(): 2015-08-17 
#> # names(): AH49008
#> # $dataprovider: PRIDE
#> # $species: Erwinia carotovora
#> # $rdataclass: mzRpwiz
#> # $title: PXD000001: raw mass spectrometry data
#> # $description: Four human TMT spliked-in proteins in an Erwinia caroto...
#> # $taxonomyid: 554
#> # $genome: NA
#> # $sourcetype: mzML
#> # $sourceurl: ftp://ftp.pride.ebi.ac.uk/pride/data/archive/2012/03/PXD0...
#> # $sourcelastmodifieddate: NA
#> # $sourcesize: NA
#> # $tags: Proteomics, TMT6, LTQ Orbitrap Velos, PMID:23692960 
#> # retrieve record with 'object[["AH49008"]]'
```

To access the actual data, raw mass spectrometry data in this case, we
double the `[[`


```r
library("mzR")
#> Warning: package 'mzR' was built under R version 3.3.0
#> Loading required package: Rcpp
#> Warning: package 'Rcpp' was built under R version 3.3.0
rw <- ah[["AH49008"]]
rw
#> Mass Spectrometry file handle.
#> Filename:  55314 
#> Number of scans:  7534
```

In this case, we have an instance of class mzRpwiz,
that can be processed as anticipated.

In the short demonstration above, we had **direct** and
**standardised** access to the raw data, without a need to manually
open this raw data or worry about the file format. The data was
prepared and converted into a **standard Bioconductor data types** for
immediate consumption by the user. This is also valid for other
relevant data types such as identification results, fasta files or
protein of peptide quantitation data.

See the `ProteomicsAnnotationHubData` vignette for details on
available data and how to add new proteomics data to AnnotationHub.
