#' @param repos `character()`\cr
#'  A vector of repositories to query. The following values are available:
#'  * `"cran"`, meaning CRAN;
#'  * `"bioc@release"`, meaning Bioconductor, where `release` should be replaced
#'    with a valid Bioconductor release code or one of `"release"`, `"devel"`;
#'  * `"github/user"`, meaning GitHub, where `user` should be replaced with a
#'    valid user or organization name (e.g. `turtletopia`);
#'  * `"runiverse@universe"`, meaning R-universe, where `universe` should be
#'    replaced with a valid universe name (e.g. `turtletopia`);
#'  * `"local#index"`, meaning a local library, where `index` should be replaced
#'    with an integer index of a library in [base::.libPaths()] or an `all`
#'    keyword;
#'  * `"core"`, meaning base R packages;
#'  * a URL if none of the above is matched.
