collapse_comma <- function(x, truncate_at = 10) {
  if (length(x) > truncate_at) {
    x <- c(x[seq_len(truncate_at)], "...")
  }

  paste(x, collapse = ", ")
}
