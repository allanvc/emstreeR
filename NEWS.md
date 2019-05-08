# emstreeR 2.2.0 (2019-05-07 - 4th CRAN patch)

## New data, functions, and features

* added 'scale' parameter in the ComputeMST() function. It gives the option to 
scale or not your data before computing the MST (Thank's to Moses Obiri who 
pointed this out).
* updated documentation in ComputeMST.R file
* updated documentation in emstreeR-package.Rd file
* deleted honeymoon example from README file, since dsk service for maps are not
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