#' @export
wood_github_tags <- function(package, user) {
  assert_param_package(package)
  assert_param_gh_user(user)

  github_tags_cache(package, user)
}

github_tags_cache <- function(package, user) {
  with_cache({
    url <- github_url("repos", user, package, "tags")
    content <- download_safely(url, on_status = list(
      `403` = stopf_gh_rate_limit,
      `404` = function() stopf(
        "Can't find repository `%1$s/%2$s` on Github.", user, package
      )
    ))
    vapply(content, `[[`, character(1), "name")
  }, "tags", "github", user, package)
}
