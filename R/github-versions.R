#' Get all tagged package versions on GitHub
#'
#' @description This function queries GitHub for the codes of all tagged package
#' versions. To get the latest available version, see [wood_github_latest()].
#'
#' @template package
#' @template git-user
#'
#' @return A character vector of version codes.
#'
#' @examplesIf !woodendesc:::is_cran_check()
#' wood_github_versions("versionsort", "turtletopia")
#'
#' @family github
#' @family versions
#' @export
wood_github_versions <- function(package, user) {
  assert_param_package(package)
  assert_param_git_user(user)

  github_versions_cache(package, user)
}

github_versions_cache <- function(package, user) {
  tags <- github_tags_cache(package, user)
  vapply(tags, function(tag) {
    ret <- github_description_cache(package, user, tag)
    read_dcf_one_value(ret, "Version")
  }, character(1), USE.NAMES = FALSE)
}
