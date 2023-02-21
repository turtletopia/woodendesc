#' Get all tagged package versions on GitHub
#'
#' @description This function queries GitHub for the codes of all tagged package
#' versions. To get the latest available version, see [wood_github_latest()].
#'
#' @template package
#' @template gh-user
#'
#' @return A character vector of version codes.
#'
#' @examples
#' \dontrun{
#' wood_github_versions("versionsort", "turtletopia")
#' }
#'
#' @family github
#' @family versions
#' @export
wood_github_versions <- function(package, user) {
  assert_param_package(package)
  assert_param_gh_user(user)

  github_versions_cache(package, user)
}

github_versions_cache <- function(package, user) {
  tags <- github_tags_cache(package, user)
  vapply(tags, function(tag) {
    ret <- with_cache({
      url <- raw_github_url(user, package, tag, "DESCRIPTION")
      content <- download_safely(url, on_status = list(
        `403` = stopf_gh_rate_limit,
        `404` = function() stopf(
          "Can't find DESCRIPTION file in `%1$s/%2$s` repository on Github.", user, package
        )
      ))
    }, "DESCRIPTION", "github", user, package, tag)
    read_dcf_one_value(ret, "Version")
  }, character(1), USE.NAMES = FALSE)
}
