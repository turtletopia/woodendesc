#' Check if R version is older than expected
#'
#' @description Check whether R version is older than expected, using comparison
#' of version codes.
#'
#' @param \[\code{character(1)}\]\cr
#'  A version code to compare to, e.g. "3.6.3"
#'
#' @return Logical vector of length one.
#'
#' @noRd
#' @importFrom versionsort ver_latest
R_older_than <- function(expected) {
  # TODO: implement with ver_older_than()
  # ver_older_than(as.character(getRversion()), expected)
  R_version <- as.character(getRversion())
  ver_latest(c(R_version, expected)) != R_version
}
