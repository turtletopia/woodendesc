guess_default_branch <- function(
    site, user, package, ..., branches = c("master", "main")
) {
  # TODO: rewrite so that we return a function of `branch` generating requests
  req <- switch(
    site,
    github = httr2::request("https://raw.githubusercontent.com") |>
      httr2::req_url_path_append(user, package),
    gitlab = httr2::request("https://gitlab.com") |>
      httr2::req_url_path_append(user, package, "-", "raw")
  )

  # First check if cache with default branch data exists
  branch <- with_cache({}, "repos", site, user)[[package]][["default_branch"]]

  if (is.null(branch)) {
    branch <- with_cache({}, "repo", site, user, package)[["default_branch"]]
  }

  # If cache found, download data from that branch
  if (!is.null(branch)) {
    resp <- req |>
      httr2::req_url_path_append(branch, ...) |>
      httr2::req_perform()
    return(resp)
  }

  # Try master, main, dev, and prod branch names
  for (b in branches) {
    try({
      resp <- req |>
        httr2::req_url_path_append(b, ...) |>
        httr2::req_perform()
      return(resp)
    }, silent = TRUE)
  }

  NULL
}
