stopf <- function(msg, ...) {
  stop(sprintf(msg, ...), call. = FALSE)
}

abort_gh_rate_limit <- function(cnd) {
  rlang::abort(
    c("Exceeded GitHub API limit of 60 queries per hour.",
      "i" = "Authentication will increase your limit.",
      "i" = "Start an issue to show us there's a demand for a higher limit."),
    parent = cnd
  )
}
