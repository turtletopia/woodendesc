% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wood-versions.R
\name{wood_versions}
\alias{wood_versions}
\title{Collect all package versions from multiple repositories}
\usage{
wood_versions(packages, repos = "cran")
}
\arguments{
\item{packages}{\code{character()}\cr
Names of the packages to query for.}

\item{repos}{\code{character()}\cr
A vector of repositories to query. The following values are available:
\itemize{
\item \code{"cran"}, meaning CRAN;
\item \code{"bioc@release"}, meaning Bioconductor, where \code{release} should be replaced
with a valid Bioconductor release code or one of \code{"release"}, \code{"devel"};
\item \code{"runiverse@universe"}, meaning R-universe, where \code{universe} should be
replaced with a valid universe name (e.g. \code{turtletopia});
\item \code{"github/user"}, meaning GitHub, where \code{user} should be replaced with a
valid user or organization name (e.g. \code{turtletopia});
\item \code{"gitlab/user"}, meaning GitLab, where \code{user} should be replaced with a
valid user or group name (e.g. \code{r-packages});
\item \code{"local#index"}, meaning a local library, where \code{index} should be replaced
with an integer index of a library in \code{\link[base:libPaths]{base::.libPaths()}} or an \code{all}
keyword;
\item \code{"core"}, meaning base R packages;
\item a URL if none of the above is matched.
}}
}
\value{
A list named after queried packages, each element being a character
vector of version codes.
}
\description{
This function queries the selected repositories for version
codes of the selected packages and collects the unique occurences.
}
\examples{
\dontshow{if (!woodendesc:::is_cran_check()) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
wood_versions("woodendesc", c("local#all", "runiverse@turtletopia"))
# Multiple packages are also possible:
wood_versions(
  c("ggplot2", "Biostrings", "woodendesc"),
  repos = c("runiverse@turtletopia", "cran", "bioc@1.5")
)
# By default, only CRAN is queried:
wood_versions("versionsort")
\dontshow{\}) # examplesIf}
}
\seealso{
Functions for all repositories:
\code{\link{wood_dependencies}()},
\code{\link{wood_packages}()}

Functions that query package versions:
\code{\link{wood_bioc_version}()},
\code{\link{wood_core_version}()},
\code{\link{wood_cran_latest}()},
\code{\link{wood_cran_versions}()},
\code{\link{wood_github_latest}()},
\code{\link{wood_github_versions}()},
\code{\link{wood_gitlab_latest}()},
\code{\link{wood_gitlab_versions}()},
\code{\link{wood_local_versions}()},
\code{\link{wood_runiverse_version}()},
\code{\link{wood_url_version}()}
}
\concept{versions}
\concept{wood}
