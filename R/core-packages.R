#' @export
wood_core_packages <- function() {
  rownames(installed.packages(priority = "base"))
}
