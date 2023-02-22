#' List core R packages
#'
#' @description This function returns the list of base R packages.
#'
#' @return A character vector of available packages.
#'
#' @examples
#' wood_core_packages()
#'
#' @family core
#' @family packages
#' @importFrom utils installed.packages
#' @export
wood_core_packages <- function() {
  rownames(installed.packages(priority = "base"))
}
