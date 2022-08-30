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
#' \donttest{
#' wood_versions("woodendesc", c("local#all", "runiverse@turtletopia"))
#' # Multiple packages are also possible:
#' wood_versions(
#'   c("ggplot2", "Biostrings", "woodendesc"),
#'   repos = c("runiverse@turtletopia", "cran", "bioc@1.5")
#' )
#' # By default, only CRAN is queried:
#' wood_versions("versionsort")
#' }
#'
#' @family wood
#' @family versions
#' @importFrom versionsort ver_sort
#' @export
wood_versions <- function(packages, repos = "cran") {
  assert_param_packages(packages)
  assert_param_repos(repos)

  query_makers <- interpret_repos(repos, context = "version")

  ret <- lapply(packages, function(package) {
    ver_sort(collect_repos(query_makers, package = package))
  })
  names(ret) <- packages
  ret
}
