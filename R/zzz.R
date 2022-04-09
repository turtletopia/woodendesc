.onLoad <- function(libname, pkgname) {
  prev_options <- options()

  new_options <- list(
    wood_cache_time = 60 * 60 * 3
  )

  unset_inds <- !(names(new_options) %in% names(prev_options))
  if (any(unset_inds)) {
    options(new_options[unset_inds])
  }

  invisible()
}
