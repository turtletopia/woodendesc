#' List GitHub tags for a repository
#'
#' @description This function queries GitHub for a list of tags for a given
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
#' \donttest{
#' wood_github_tags("gglgbtq", "turtletopia")
#' # Sometimes there are no tags (yet?)
#' wood_github_tags("ggpizza", "turtletopia")
#' }
#'
#' @family github
#' @export
wood_github_tags <- function(package, user) {
  assert_param_package(package)
  assert_param_git_user(user)

  github_tags_cache(package, user)
}

github_tags_cache <- function(package, user) {
  with_cache({
    content <- rlang::try_fetch({
      httr2::request("https://api.github.com") |>
        httr2::req_url_path_append("repos", user, package, "tags") |>
        httr2::req_perform() |>
        httr2::resp_body_json()
    }, httr2_http_403 = function(cnd) {
      abort_gh_rate_limit(cnd)
    }, httr2_http_404 = function(cnd) {
      rlang::abort(
        sprintf("Can't find repository `%1$s/%2$s` on Github.", user, package),
        parent = cnd
      )
    })
    vapply(content, function(x) { x[["name"]] }, character(1))
  }, "tags", "github", user, package)
}
