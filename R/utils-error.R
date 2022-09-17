stopf <- function(msg, ...) {
  stop(sprintf(msg, ...), call. = FALSE)
}

stopf_gh_rate_limit <- function() {
  stopf(c(
    "Exceeded GitHub API limit of 60 queries per hour.\n",
    "(i) Authentication will increase your limit.\n",
    "(i) Start an issue to show us there's a demand for a higher limit."
  ))
}
