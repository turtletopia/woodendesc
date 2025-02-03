#' Collect all package versions from multiple repositories
#'
#' @description This function queries the selected repositories for version
#' codes of the selected packages and collects the unique occurences.
#'
#' @template packages
#' @template repos
#'
#' @return A list named after queried packages, each element being a character
#' vector of version codes.
#'
#' @examples
#' ## Only run with internet access
#' if (interactive()) {
#' wood_versions("woodendesc", c("local#all", "runiverse@turtletopia"))
#' }
#'
#' if (interactive()) {
#' # Multiple packages are also possible:
#' wood_versions(
#'   c("ggplot2", "Biostrings", "woodendesc"),
#'   repos = c("runiverse@turtletopia", "cran", "bioc@1.5")
#' )
#' }
#'
#' if (interactive()) {
#' # By default, only CRAN is queried:
#' wood_versions("versionsort")
#' }
#'
#' @family wood
#' @family versions
#' @export
wood_versions <- function(packages, repos = "cran") {
  assert_param_packages(packages)
  assert_param_repos(repos)

  query_makers <- interpret_repos(repos, context = "version")

  lapply(packages, function(package) {
    versionsort::ver_sort(collect_repos(query_makers, package = package))
  }) |>
    rlang::set_names(packages)
}
