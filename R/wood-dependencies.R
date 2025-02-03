#' Find dependencies from multiple repositories
#'
#' @description This function queries the selected repositories for dependencies
#' of the selected packages and returns the first working occurence.
#'
#' @template packages
#' @template repos
#'
#' @return A list named after queried packages, each element being a data frame
#' with three columns, all in string format:
#' * `package` (package name),
#' * `version` (minimum version requirement or `NA` if none),
#' * `type` (dependency type, e.g. `"Imports"`).
#'
#' @examples
#' wood_dependencies("stats", "core")
#'
#' ## Only run with internet access
#' if (interactive()) {
#' # Multiple packages are also possible:
#' wood_dependencies(
#'   c("tibble", "Biostrings", "woodendesc"),
#'   repos = c("runiverse@turtletopia", "cran", "bioc@1.8")
#' )
#' }
#'
#' if (interactive()) {
#' # By default, only CRAN is queried:
#' wood_dependencies("versionsort")
#' }
#'
#' @family wood
#' @family dependencies
#' @export
wood_dependencies <- function(packages, repos = "cran") {
  assert_param_packages(packages)
  assert_param_repos(repos)

  query_makers <- interpret_repos(repos, context = "dependencies")

  lapply(packages, function(package) {
    try_repos(query_makers, package = package)
  }) |>
    rlang::set_names(packages) |>
    as_wood_dep_list()
}
