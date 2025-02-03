#' Get current package version in one of R universes
#'
#' @description This function queries the selected universe for the code of the
#' current version of the selected package.
#'
#' @template package
#' @template universe
#'
#' @return A single string with a version code.
#'
#' @examples
#' ## Only run with internet access
#' if (interactive()) {
#' wood_runiverse_version("ggplot2", universe = "tidyverse")
#' }
#'
#' @family runiverse
#' @family versions
#' @export
wood_runiverse_version <- function(package, universe = "ropensci") {
  assert_param_package(package)
  assert_param_runiverse(universe)

  # TODO: use runiverse_packages_cache() output if possible
  runiverse_description_cache(package, universe)[["version"]]
}

runiverse_description_cache <- function(package, universe = "ropensci") {
  with_cache({
    desc <- rlang::try_fetch({
      httr2::request(sprintf("https://%s.r-universe.dev", universe)) |>
        httr2::req_url_path_append("api", "packages", package) |>
        httr2::req_perform() |>
        httr2::resp_body_json()
    }, httr2_http_404 = function(cnd) {
      rlang::abort(
        sprintf("Can't find package `%1$s` in universe `%2$s`.", package, universe),
        parent = cnd
      )
    })

    # Save selected description fields
    list(
      version = desc[["Version"]],
      deps = desc[["_dependencies"]]
    )
  }, "description", "runiverse", universe, package)
}
