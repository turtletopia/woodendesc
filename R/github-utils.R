is_github_R_repo <- function(repo) {
  owner <- repo[["owner"]][["login"]]
  name <- repo[["name"]]
  branch <- repo[["default_branch"]]
  ret <- with_cache({
    rlang::try_fetch({
      content <- httr2::request("https://raw.githubusercontent.com") |>
        httr2::req_url_path_append(owner, name, branch, "DESCRIPTION") |>
        httr2::req_perform() |>
        httr2::resp_body_string()
      list(exists = TRUE, content = content)
    }, error = function(cnd) {
      list(exists = FALSE, content = NULL)
    })
  }, "DESCRIPTION", "github", owner, name)
  ret[["exists"]]
}

is_fork <- function(repo) {
  repo[["fork"]]
}

# TODO: completely rethink branch guessing with httr2
guess_default_branch_gh <- function(user, package, ...) {
  ret <- guess_default_branch("github", user, package, ...)

  if (!is.null(ret)) {
    return(ret)
  }

  # If failed, download data with default branch name
  repo_data <- with_cache({
    rlang::try_fetch({
      httr2::request("https://api.github.com") |>
        httr2::req_url_path_append("repos", user, package) |>
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
  }, "repo", "github", user, package)
  branch <- repo_data[["default_branch"]]

  httr2::request("https://raw.githubusercontent.com") |>
    httr2::req_url_path_append(user, package, branch, ...) |>
    httr2::req_perform()
}
