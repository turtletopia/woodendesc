#' Collect available packages from multiple repositories
#'
#' @description This function queries the selected repositories for the
#' available packages and collects the unique occurrences.
#'
#' @template repos
#'
#' @return A character vector of available packages.
#'
#' @examples
#' \donttest{
#' # head() used due to the number of packages in there
#' head(wood_packages(c("local#all", "bioc@1.7", "cran", "core")))
#' wood_packages(c("http://www.omegahat.net/R", "runiverse@turtletopia"))
#' # By default, only CRAN is queried:
#' head(wood_packages())
#' }
#'
#' @family wood
#' @family packages
#' @export
wood_packages <- function(repos = "cran") {
  assert_param_repos(repos)

  query_makers <- interpret_repos(repos, context = "packages")

  sort(collect_repos(query_makers))
}
