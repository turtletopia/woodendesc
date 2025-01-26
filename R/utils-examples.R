is_cran_check <- function() {
  !identical(Sys.getenv("NOT_CRAN"), "true") && Sys.getenv("_R_CHECK_PACKAGE_NAME_", "") != ""
}
