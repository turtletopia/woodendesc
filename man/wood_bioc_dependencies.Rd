% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bioc-dependencies.R
\name{wood_bioc_dependencies}
\alias{wood_bioc_dependencies}
\title{Get dependencies of a package in Bioconductor}
\usage{
wood_bioc_dependencies(package, release = "release")
}
\arguments{
\item{package}{\code{character(1)}\cr
Name of a package to query for.}

\item{release}{\code{character(1)}\cr
Bioconductor release to query for. Can be either a numeric code (like
\code{3.12}) or one of two keywords: \code{"release"} and \code{"devel"}.}
}
\value{
A data frame with three columns, all in string format:
\itemize{
\item \code{package} (package name),
\item \code{version} (minimum version requirement or \code{NA} if none),
\item \code{type} (dependency type, e.g. \code{"Imports"}).
}
}
\description{
This function queries Bioconductor for dependencies of the
selected package for given Bioconductor release.
}
\examples{
\dontshow{if (!woodendesc:::is_cran_check()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
wood_bioc_dependencies("Biostrings")

# Will dependencies change?
wood_bioc_dependencies("Biostrings", "devel")
# And what about dependencies in the past?
wood_bioc_dependencies("Biostrings", "2.10")
wood_bioc_dependencies("Biostrings", "1.8")
\dontshow{\}) # examplesIf}
}
\seealso{
Functions for Bioconductor:
\code{\link{wood_bioc_packages}()},
\code{\link{wood_bioc_releases}()},
\code{\link{wood_bioc_version}()}

Functions that query package dependencies:
\code{\link{wood_core_dependencies}()},
\code{\link{wood_cran_dependencies}()},
\code{\link{wood_dependencies}()},
\code{\link{wood_github_dependencies}()},
\code{\link{wood_gitlab_dependencies}()},
\code{\link{wood_local_dependencies}()},
\code{\link{wood_runiverse_dependencies}()},
\code{\link{wood_url_dependencies}()}
}
\concept{bioc}
\concept{dependencies}
