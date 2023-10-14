#' Get current package version on GitLab
#'
#' @description This function queries GitLab for the code of the current package
#' version. This may reference a non-tagged commit; for the analysis of tagged
#' commits only, see [wood_gitlab_versions()].
#'
#' @template package
#' @template git-user
#'
#' @return A character vector of version codes.
#'
#' @examples
#' \donttest{
#' # Latest version code is returned
#' wood_gitlab_latest("rock", "r-packages")
#'
#' # To get the latest *tagged* version code instead, use:
#' codes <- wood_gitlab_versions("rock", "r-packages")
#' versionsort::ver_latest(codes)
#' }
#'
#' @family gitlab
#' @family versions
#' @export
wood_gitlab_latest <- function(package, user) {
  assert_param_package(package)
  assert_param_git_user(user)

  desc <- gitlab_description_cache(package, user, "latest")
  read_dcf_one_value(desc, "Version")
}

gitlab_description_cache <- function(package, user, tag) {
  if (tag == "latest") {
    ret <- with_cache({
      content <- guess_default_branch(user, package, "DESCRIPTION")
      list(exists = TRUE, content = content)
    }, "DESCRIPTION", "github", user, package)
    ret[["content"]]
  } else {
    # with_cache({
    #   url <- raw_github_url(user, package, tag, "DESCRIPTION")
    #   content <- download_safely(url, on_status = list(
    #     `403` = stopf_gh_rate_limit,
    #     `404` = function() stopf(c(
    #       "Can't find DESCRIPTION file in `%1$s/%2$s` repository on Github.\n",
    #       "(i) Is `%3$s` a valid tag?"
    #     ), user, package, tag)
    #   ))
    # }, "DESCRIPTION", "github", user, package, tag)
  }
}
