validate_bioc_package <- function(desc, package, release) {
  if (is.null(desc)) {
    rlang::abort(
      sprintf("Can't find package `%1$s` in Bioconductor release `%2$s`.", package, release)
    )
  }
}

validate_bioc_release <- function(release) {
  # Early return for special release names
  if (release %in% c("release", "devel")) {
    return()
  }

  # Perform precise check only if xml2 installed
  if (rlang::is_installed("xml2")) {
    if (!release %in% wood_bioc_releases()) {
      rlang::abort(
        sprintf("Bioconductor release %1$s does not exist.", release)
      )
    }
  }

  # TODO: replace with ver_earlier_than() or sth like that
  # Release at least 1.8
  if (versionsort::ver_latest(c(release, "1.8")) != release) {
    rlang::abort(
      c("`release` must be at least 1.8.",
        "i" = sprintf("You've provided release code %1$s.", release),
        "i" = "Releases older than 1.8 are not supported.")
    )
  }
}
