#' List available packages in one of R universes
#'
#' @description This function queries the selected universe for a list of
#' available packages. They are returned as a vector of strings, each element
#' being a package name.
#'
#' @template universe
#'
#' @return A character vector of available packages.
#'
#' @examples
#' \donttest{
#' wood_runiverse_packages()
#' wood_runiverse_packages("tidyverse")
#' }
#'
#' @family runiverse
#' @family packages
#' @export
wood_runiverse_packages <- function(universe = "ropensci") {
  assert_param_runiverse(universe)

  runiverse_packages_cache(universe)
}

runiverse_packages_cache <- function(universe = "ropensci") {
  packages <- with_cache({
    httr2::request(sprintf("https://%s.r-universe.dev", universe)) |>
      httr2::req_url_path_append("api", "packages") |>
      httr2::req_error(
        is_error = function(resp) {
          resp |>
            httr2::resp_body_json() |>
            identical(list())
        },
        body = function(resp) {
          c("x" = "Received package list is empty.",
            "*" = sprintf("Does universe `%1$s` exist?", universe))
        }
      ) |>
      httr2::req_perform() |>
      httr2::resp_body_json()
  }, "packages", "runiverse", universe)

  packages |>
    vapply(function(x) { x[["Package"]] }, character(1))
}
