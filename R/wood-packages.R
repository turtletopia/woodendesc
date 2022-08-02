#' @export
wood_packages <- function(repos = "cran") {
  query_makers <- interpret_repos(repos, context = "packages")

  sort(collect_repos(query_makers))
}
