#' Get all tagged package versions on GitLab
#'
#' @description This function queries GitLab for the codes of all tagged package
#' versions. To get the latest available version, see [wood_gitlab_latest()].
#'
#' @template package
#' @template git-user
#'
#' @return A character vector of version codes.
#'
#' @examplesIf !woodendesc:::is_cran_check()
#' wood_gitlab_versions("rock", "r-packages")
#'
#' @family gitlab
#' @family versions
#' @export
wood_gitlab_versions <- function(package, user) {
  assert_param_package(package)
  assert_param_git_user(user)

  gitlab_versions_cache(package, user)
}

gitlab_versions_cache <- function(package, user) {
  tags <- gitlab_tags_cache(package, user)
  vapply(tags, function(tag) {
    ret <- gitlab_description_cache(package, user, tag)
    read_dcf_one_value(ret, "Version")
  }, character(1), USE.NAMES = FALSE)
}
