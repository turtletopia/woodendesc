#' Get current version of a core R package
#'
#' @description This function checks the version of the selected core R package.
#'
#' @template package
#'
#' @return A single string with a version code. Should be equal to the R version
#' (\code{\link[base]{getRversion}()}).
#'
#' @examples
#' \donttest{
#' wood_core_version("graphics")
#' }
#'
#' @family core
#' @family versions
#' @importFrom utils installed.packages
#' @export
wood_core_version <- function(package) {
  core_pkgs <- installed.packages(priority = "base")

  if (!package %in% rownames(core_pkgs))
    stop("package not part of R core", call. = FALSE)

  core_pkgs[package, "Version"]
}
