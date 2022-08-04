#' @importFrom versionsort ver_sort
#' @export
wood_versions <- function(packages, repos = "cran") {
  query_makers <- interpret_repos(repos, context = "version")

  ret <- lapply(packages, function(package) {
    ver_sort(collect_repos(query_makers, package = package))
  })
  names(ret) <- packages
  ret
}
