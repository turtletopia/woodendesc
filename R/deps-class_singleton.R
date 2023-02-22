as_wood_deps <- function(df) {
  # Colnames should be "package", "version", and "type", in this order
  if (!identical(colnames(df), c("package", "version", "type")))
    stop("Unexpected set of columns in dependency list.", call. = FALSE)

  structure(
    df,
    class = c("wood_deps", class(df))
  )
}

#' @export
print.wood_deps <- function(x, ..., package = NULL) {
  # Header
  if (is.null(package)) {
    cat("<dependencies>\n")
  } else {
    cat(sprintf(" <%s dependencies>\n", package))
  }

  # Body
  for (i in seq_len(nrow(x))) {
    cat(sprintf(
      "  %1$-12s %2$s",
      paste0(x[[i, "type"]], ":"),
      x[[i, "package"]]
    ))
    if (!is.na(x[[i, "version"]])) {
      cat(sprintf(" (>= %s)", x[[i, "version"]]))
    }
    cat("\n")
  }
}
