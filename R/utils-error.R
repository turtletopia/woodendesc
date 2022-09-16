stopf <- function(msg, ...) {
  stop(sprintf(msg, ...), call. = FALSE)
}
