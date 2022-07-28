#' @export
wood_bioc_version <- function(package, release = "release") {
  desc <- bioc_PACKAGES_cache(release)[[package]]

  if (is.null(desc))
    stop("Package not found in the specified Bioconductor release.", call. = FALSE)

  desc[["Version"]]
}
