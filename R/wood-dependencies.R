#' @export
wood_dependencies <- function(packages, repos = "cran") {
  query_makers <- interpret_repos(repos, context = "dependencies")

  ret <- lapply(packages, function(package) {
    try_repos(query_makers, package = package)
  })
  names(ret) <- packages
  ret
}
