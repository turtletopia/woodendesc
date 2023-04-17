
<!-- README.md is generated from README.Rmd. Please edit that file -->

# woodendesc <a href="https://turtletopia.github.io/woodendesc/"><img src="man/figures/logo.png" align="right" height="138" /></a>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version-last-release/woodendesc)](https://CRAN.R-project.org/package=woodendesc)
[![R-universe](https://turtletopia.r-universe.dev/badges/woodendesc)](https://turtletopia.r-universe.dev)
[![R-CMD-check](https://github.com/turtletopia/woodendesc/workflows/R-CMD-check/badge.svg)](https://github.com/turtletopia/woodendesc/actions)
[![Codecov test
coverage](https://codecov.io/gh/turtletopia/woodendesc/branch/master/graph/badge.svg)](https://app.codecov.io/gh/turtletopia/woodendesc?branch=master)
<!-- badges: end -->

{woodendesc} strives to provide an unified API to query any R repository
for the following data:

- list of available packages,
- version code of any selected package,
- direct dependencies of any selected package.

The package tries to cache as much as possible and reuse existing cache
wherever possible to minimize internet usage. Many repositories (CRAN,
Bioconductor, R-universe, and local libraries) have custom
implementations of their handlers to make use of additional
possibilities they present (e.g. previous versions on CRAN or old
releases of Bioconductor).

## Installation

``` r
# Install from CRAN
install.packages("woodendesc")
# Install the development version from GitHub:
# install.packages("devtools")
devtools::install_github("turtletopia/woodendesc")
```

## How to use woodendesc?

Each repository has its dedicated functions for listing available
packages, package version, and package dependencies.

A list of available packages is returned as a character vector. An
example call returning a list of CRAN packages:

``` r
library(woodendesc)
# Too many packages to list them all
all_cran_pkgs <- wood_cran_packages()
head(all_cran_pkgs, 10)
#>  [1] "A3"            "AalenJohansen" "AATtools"      "ABACUS"       
#>  [5] "abbreviate"    "abbyyR"        "abc"           "abc.data"     
#>  [9] "ABC.RAP"       "ABCanalysis"
```

An available package version is returned as a single code. An example
call checking the current version of Biobase package on Bioconductor:

``` r
wood_bioc_version("Biobase")
#> [1] "2.58.0"
```

Dependencies of a package are returned as a data frame with the same set
of columns for all calls. An example call for locally installed digest
package (dependency of woodendesc):

``` r
wood_local_dependencies("digest")
#> <dependencies>
#>   Depends:     R (>= 3.3.0)
#>   Imports:     utils
#>   Suggests:    tinytest
#>   Suggests:    simplermarkdown
```

Note that some repositories store more than just one version of a
package (e.g. CRAN and Github). These cases can be distinguished by
pluralized `_versions` function name component and they return all
version codes instead; a character vector of any length. This is how it
works for gglgbtq on Github:

``` r
wood_github_versions("gglgbtq", "turtletopia")
#> [1] "0.1.1" "0.1.0"
```

If a single version code is needed, there’s a counterpart that selects
the latest version only. The current version of aurrera on Github is:

``` r
wood_github_latest("aurrera", "turtletopia")
#> [1] "0.1.0"
```

Last, but not least, there are three functions for searching through
multiple repositories and collecting the results. Read the documentation
for details on how to specify `repos` parameter.

`wood_packages()` collects available packages from the specified
repositories and returns unique elements:

``` r
wood_packages(repos = c("core", "https://colinfay.me"))
#>  [1] "attempt"        "base"           "compiler"       "craneur"       
#>  [5] "datasets"       "devaddins"      "dockerfiler"    "fryingpane"    
#>  [9] "graphics"       "grDevices"      "grid"           "jekyllthat"    
#> [13] "languagelayeR"  "methods"        "parallel"       "proustr"       
#> [17] "rgeoapi"        "rpinterest"     "splines"        "stats"         
#> [21] "stats4"         "tcltk"          "tidystringdist" "tools"         
#> [25] "utils"
```

`wood_versions()` returns all package versions available on at least one
of the specified repositories; may take more than one package:

``` r
wood_versions(
  c("aurrera", "woodendesc"),
  repos = c("local#all", "runiverse@turtletopia", "cran")
)
#> $aurrera
#> [1] "0.1.0"
#> 
#> $woodendesc
#> [1] "0.1.0"
```

`wood_dependencies()` returns a list of package dependencies, a data
frame for each package specified; the first working repository is used
for each package, as the dependencies are not supposed to be summable:

``` r
wood_dependencies(
  c("versionsort", "gglgbtq"),
  repos = c("local#all", "runiverse@turtletopia", "cran")
)
#> <woodendesc dependency list [2]>
#>  <versionsort dependencies>
#>   Suggests:    covr
#>   Suggests:    spelling
#>   Suggests:    testthat (>= 3.0.0)
#> 
#>  <gglgbtq dependencies>
#>   Imports:     ggplot2
#>   Imports:     graphics
#>   Imports:     grDevices
#>   Suggests:    knitr
#>   Suggests:    rmarkdown
#>   Suggests:    spelling
#>   Suggests:    testthat (>= 3.0.0)
```

And if you ever need to clear cache, simply call:

``` r
wood_clear_cache()
```

## End notes

I believe in equal rights and treatment for everybody, regardless of
their sexuality, gender identity, skin tone, nationality, and other
features beyond human control. Thus, I do not allow woodendesc to be
used in any project that promotes hate based on the aforementioned
factors.
