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
#' print(wood_packages(c("local#all", "bioc@1.7", "cran", "core")), max = 15)
#' wood_packages(c("https://colinfay.me", "runiverse@turtletopia"))
#' # By default, only CRAN is queried:
#' print(wood_packages(), max = 15)
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
