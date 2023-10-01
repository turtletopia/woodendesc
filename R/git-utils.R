guess_default_branch <- function(site, user, package, ...,
                                 branches = c("master", "main")) {
  url_generator <- switch(
    site,
    github = raw_github_url,
    gitlab = function(user, package) {
      gitlab_url(user, package, "-", "raw")
    }
  )

  url <- url_generator(user, package)

  # First check if cache with default branch data exists
  branch <- with_cache({}, "repos", site, user)[[package]][["default_branch"]]

  if (is.null(branch)) {
    branch <- with_cache({}, "repo", site, user, package)[["default_branch"]]
  }

  # If cache found, download data from that branch
  if (!is.null(branch)) {
    return(download_safely(paste(url, branch, ..., sep = "/")))
  }

  # Try master, main, dev, and prod branch names
  for (b in branches) {
    try({
      return(download_safely(paste(url, b, ..., sep = "/")))
    })
  }

  NULL
}
