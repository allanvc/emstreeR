# emstreeR (2023-11-13 - CRAN update)

* carries all the updates after 3.0.0 to CRAN
* removed emstreeR-package.Rd to avoid CRAN notes
* incorporates new vignette showing how to export shapefiles

# emstreeR 3.1.0 (2023-11-07 - Github patch)

## doc 

* updated DESCRIPTION and README


## new features

* included support to export to export output to shapefiles (new functions: `export_vertices_to_shapefile()` and `export_edges_to_shapefile()`)

## bug fix

* `plot.MST` was not being exported. Included #'@export in the documentation file

## others

* removed dependency BBMisc

# emstreeR 3.0.0 (2020-03-17 - Github patch/CRAN update)

* Migrated from RcppMLPACK to mlpack [thanks to @nacnudus] [#3]

## doc

* updated DESCRIPTION and README


# emstreeR 2.2.2 (2020-11-29 - Github patch/CRAN update)

## functions

* data_check() and mlpack_mst's doc are now @noRd

## doc

* fixed typos in DESCRIPTION and README

* incorporated the pull request 1

## bug fix

* fixed the documentation (.Rd) file of `computeMST()`. A wrong link was causing the malfunction in the dev version.

---

# emstreeR 2.2.1 (2019-08-20 - Github patch)

## functions

* data_check() and mlpack_mst are now internal
* changed .Rbuildignore to ignore README.Rmd, NEWS.md, cran-comments.md and the
/inst folder

---

# emstreeR 2.2.0 (2019-05-07 - 4th CRAN patch)

## New data, functions, and features

* added 'scale' parameter in the ComputeMST() function. It gives the option to 
scale or not your data before computing the MST (Thank's to Moses Obiri who 
pointed this out).
* updated documentation in ComputeMST.R file
* updated documentation in emstreeR-package.Rd file
* deleted honeymoon example (extras) from README file, since dsk service for maps are not
available anymore.

---

# emstreeR 2.1.2 (2019-03-13 - third CRAN patch)

## New data, functions, and features

* updated DESCRIPTION file.
* fixed citations in DESCRIPTION, README and emstreeR-package.Rd
* updated documentation in the ComputeMST.R file 

---

# emstreeR 2.1.1 (2019-01-19 - second CRAN patch)

## Internal

* Fixed Imports in DESCRIPTION file, removing the mention to RcppMLPACK in order
to eliminate NOTES when building on Fedora and Solaris

## New data, functions, and features

* updated DESCRIPTION file.
* updated 'emstreeR-package' file.
* updated 'README.md' file.

---

# emstreeR 2.1.0 (2018-12-06 - first CRAN patch)

## Internal

* Fixed compilation in OS X and Solaris:
  - copied 'Makervars' and 'Makevars.win' from RcppMLPACK with minor modifications
  - added //Rcpp[[depends(RcppMLPACK)]] to mlpack_mst.cpp file

## New data, functions, and features

* fixed typos in the DESCRIPTION file.

---

# emstreeR 2.0.0 (2018-11-28 - pre CRAN release)

## Internal

* Fix [-Wlang-lang] windows compilation WARNINGs when running devtools::win_check() 
  by adding `CXX_STD = CXX_11` line to the Makevars.win file. Reference: "Writing
  R Extensions" manual, section 1.2.4 - "Using C++11 code".

## New data, functions, and features

* Substituted the wrapper function `plotMST()` for the S3 method `plot.MST()`

* Added 'dontrun' example 'honeymoon cruise' to the package README file 

* Removed broken Japan 'dontrun' example from the package help page 
  'emstreeR-package.Rd'because of the token problem with GoogleMaps API.

* fixed errors in the DESCRIPTION file as suggested by CRAN
