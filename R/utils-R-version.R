#' @importFrom versionsort ver_latest
R_older_than <- function(expected) {
  # TODO: implement with ver_older_than()
  # ver_older_than(as.character(getRversion()), expected)
  R_version <- as.character(getRversion())
  ver_latest(c(R_version, expected)) != R_version
}
