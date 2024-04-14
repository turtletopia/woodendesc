is_gitlab_user <- function(user) {
  with_cache({
    rlang::try_fetch({
      content <- httr2::request("https://gitlab.com") |>
        httr2::req_url_path_append("api", "v4", "users") |>
        httr2::req_url_query(username = user) |>
        httr2::req_perform() |>
        httr2::resp_body_json()
      # If is GitLab user, then the response is not empty
      length(content) > 0
    }, httr2_http_403 = function(cnd) {
      abort_gh_rate_limit(cnd)
    })
  }, "user", "gitlab", user)
}

is_gitlab_R_repo <- function(repo) {
  owner <- repo[["namespace"]][["path"]]
  name <- repo[["path"]]
  branch <- repo[["default_branch"]]
  ret <- with_cache({
    rlang::try_fetch({
      content <- httr2::request("https://gitlab.com") |>
        httr2::req_url_path_append(owner, name, "-", "raw", branch, "DESCRIPTION") |>
        httr2::req_perform() |>
        httr2::resp_body_string()
      list(exists = TRUE, content = content)
    }, error = function(cnd) {
      list(exists = FALSE, content = NULL)
    })
  }, "DESCRIPTION", "gitlab", owner, name)
  ret[["exists"]]
}

is_gitlab_fork <- function(repo) {
  !is.null(repo[["forked_from_project"]])
}

guess_default_branch_gl <- function(user, package, ...) {
  ret <- guess_default_branch("gitlab", user, package, ..., branches = c("master", "main", "dev", "prod"))

  if (!is.null(ret)) {
    return(ret)
  }

  rlang::abort(
    sprintf("Can't find repository `%1$s/%2$s` on Gitlab.", user, package)
  )
}
