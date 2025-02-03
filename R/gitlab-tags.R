#' List GitLab tags for a repository
#'
#' @description This function queries GitLab for a list of tags for a given
#' repository (indicated by a combination of package name and username). Each
#' element is a tag, which need not be identical or even related to version code
#' of the package at the given time.
#'
#' @template package
#' @template git-user
#'
#' @return A character vector of repository tags.
#'
#' @examples
#' ## Only run with internet access
#' if (interactive()) {
#' wood_gitlab_tags("rock", "r-packages")
#' }
#'
#' @family gitlab
#' @export
wood_gitlab_tags <- function(package, user) {
  assert_param_package(package)
  assert_param_git_user(user)

  gitlab_tags_cache(package, user)
}

gitlab_tags_cache <- function(package, user) {
  with_cache({
    content <- rlang::try_fetch({
      httr2::request("https://gitlab.com") |>
        httr2::req_url_path_append("api", "v4", "projects", paste0(user, "%2F", package), "repository", "tags") |>
        httr2::req_perform() |>
        httr2::resp_body_json()
    }, httr2_http_429 = function(cnd) {
      abort_gl_rate_limit(cnd)
    }, httr2_http_404 = function(cnd) {
      rlang::abort(
        sprintf("Can't find repository `%1$s/%2$s` on GitLab.", user, package),
        parent = cnd
      )
    })
    vapply(content, function(x) { x[["name"]] }, character(1))
  }, "tags", "gitlab", user, package)
}
