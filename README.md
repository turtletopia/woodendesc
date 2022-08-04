
# woodendesc

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version-last-release/woodendesc)](https://CRAN.R-project.org/package=woodendesc)
[![R-CMD-check](https://github.com/turtletopia/woodendesc/workflows/R-CMD-check/badge.svg)](https://github.com/turtletopia/woodendesc/actions)
[![Codecov test
coverage](https://codecov.io/gh/turtletopia/woodendesc/branch/master/graph/badge.svg)](https://codecov.io/gh/turtletopia/woodendesc?branch=master)
<!-- badges: end -->

woodendesc strives to provide an unified API to query any R repository
for the following data:

-   list of available packages,
-   version code of any selected package,
-   direct dependencies of any selected package.

The package tries to cache as much as possible and reuse existing cache
wherever possible to minimize internet usage. Many repositories (CRAN,
Bioconductor, R-universe, and local libraries) have custom
implementations of their handlers to make use of additional
possibilities they present (e.g. previous versions on CRAN or old
releases of Bioconductor).

## Installation

``` r
# Install the development version from GitHub:
# install.packages("devtools")
devtools::install_github("turtletopia/woodendesc")
```

## How to use woodendesc?

Each repository has its dedicated functions for listing available
packages, package version, and package dependencies:

``` r
library(woodendesc)

# Too many packages to list them all
wood_bioc_packages() |> head()
```

    ## [1] "a4"          "a4Base"      "a4Classif"   "a4Core"      "a4Preproc"  
    ## [6] "a4Reporting"

``` r
wood_bioc_version("Biobase")
```

    ## [1] "2.56.0"

``` r
wood_bioc_dependencies("Biobase")
```

    ##        package version     type
    ## 1            R    2.10  Depends
    ## 2 BiocGenerics  0.27.1  Depends
    ## 3        utils    <NA>  Depends
    ## 4      methods    <NA>  Imports
    ## 5        tools    <NA> Suggests
    ## 6    tkWidgets    <NA> Suggests
    ## 7          ALL    <NA> Suggests
    ## 8        RUnit    <NA> Suggests
    ## 9   golubEsets    <NA> Suggests

Sometimes a repository may contain multiple versions of the same
package, this is signified by pluralizing `_version` in function name,
as in CRAN:

``` r
wood_cran_versions("versionsort")
```

    ## [1] "1.0.0" "1.1.0"

The other functions can query R-universe, local libraries or base R
packages:

``` r
wood_runiverse_version("woodendesc", universe = "turtletopia")
```

    ## [1] "0.1.0"

``` r
wood_local_dependencies("httr", paths = "all")
```

    ##      package version     type
    ## 1          R     3.2  Depends
    ## 2       curl   3.0.0  Imports
    ## 3   jsonlite    <NA>  Imports
    ## 4       mime    <NA>  Imports
    ## 5    openssl     0.8  Imports
    ## 6         R6    <NA>  Imports
    ## 7       covr    <NA> Suggests
    ## 8     httpuv    <NA> Suggests
    ## 9       jpeg    <NA> Suggests
    ## 10     knitr    <NA> Suggests
    ## 11       png    <NA> Suggests
    ## 12     readr    <NA> Suggests
    ## 13 rmarkdown    <NA> Suggests
    ## 14  testthat   0.8.0 Suggests
    ## 15      xml2    <NA> Suggests

``` r
wood_core_packages()
```

    ##  [1] "base"      "compiler"  "datasets"  "graphics"  "grDevices" "grid"     
    ##  [7] "methods"   "parallel"  "splines"   "stats"     "stats4"    "tcltk"    
    ## [13] "tools"     "utils"

And if none of the above satisfies your use case, there are default
`_url_` functions:

``` r
wood_url_packages("https://colinfay.me")
```

    ##  [1] "craneur"        "jekyllthat"     "tidystringdist" "attempt"       
    ##  [5] "rpinterest"     "rgeoapi"        "proustr"        "languagelayeR" 
    ##  [9] "fryingpane"     "dockerfiler"    "devaddins"

``` r
wood_url_version("XML", "http://www.omegahat.net/R")
```

    ## [1] "3.99-0"

``` r
wood_url_dependencies("XML", "http://www.omegahat.net/R")
```

    ##   package version     type
    ## 1       R   1.2.0  Depends
    ## 2   utils    <NA>  Depends
    ## 3 methods    <NA>  Imports
    ## 4  bitops    <NA> Suggests
    ## 5   RCurl    <NA> Suggests

Last, but not least, there are three functions for searching through
multiple repositories and collecting the results. Read the documentation
for details on how to specify `repos` parameter.

``` r
# These functions collect data from all repositories and return unique elements
wood_packages(repos = c("core", "https://colinfay.me"))
```

    ##  [1] "attempt"        "base"           "compiler"       "craneur"       
    ##  [5] "datasets"       "devaddins"      "dockerfiler"    "fryingpane"    
    ##  [9] "graphics"       "grDevices"      "grid"           "jekyllthat"    
    ## [13] "languagelayeR"  "methods"        "parallel"       "proustr"       
    ## [17] "rgeoapi"        "rpinterest"     "splines"        "stats"         
    ## [21] "stats4"         "tcltk"          "tidystringdist" "tools"         
    ## [25] "utils"

``` r
# wood_versions() and wood_dependencies() can take multiple packages
wood_versions(
  c("versionsort", "woodendesc"),
  c("local#all", "runiverse@turtletopia", "cran")
)
```

    ## $versionsort
    ## [1] "1.0.0" "1.1.0"
    ## 
    ## $woodendesc
    ## [1] "0.1.0"

``` r
# This one returns the first working occurence instead
wood_dependencies(
  c("versionsort", "woodendesc"),
  c("local#all", "runiverse@turtletopia", "cran")
)
```

    ## $versionsort
    ##    package version     type
    ## 1     covr    <NA> Suggests
    ## 2 spelling    <NA> Suggests
    ## 3 testthat   3.0.0 Suggests
    ## 
    ## $woodendesc
    ##        package version     type
    ## 1            R   3.5.0  Depends
    ## 2       digest    <NA>  Imports
    ## 3         httr    <NA>  Imports
    ## 4  versionsort   1.1.0  Imports
    ## 5     httptest    <NA> Suggests
    ## 6     testthat   3.0.0 Suggests
    ## 7      usethis    <NA> Suggests
    ## 8          vcr    <NA> Suggests
    ## 9        withr    <NA> Suggests
    ## 10        xml2    <NA> Suggests

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
