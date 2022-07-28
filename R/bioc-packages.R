#' @export
wood_bioc_packages <- function(release = "release") {
  packages <- vapply(
    bioc_PACKAGES_cache(release), `[[`, character(1), "Package"
  )
  unique(packages)
}

bioc_PACKAGES_cache <- function(release = "release") {
  with_cache({
    download_repo_data(bioc_release_url(
      release = release, "src", "contrib"
    ))
  }, "PACKAGES", "bioc", release)
}
