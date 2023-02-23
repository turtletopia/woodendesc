as_wood_dep_squashed <- function(df) {
  # Colnames should be "origin", "package", "version", and "type"; in this order
  if (!identical(colnames(df), c("origin", "package", "version", "type")))
    stop("Unexpected set of columns in squashed dependency list.", call. = FALSE)

  structure(
    df,
    class = c("wood_dep_squashed", class(df))
  )
}

#' @export
print.wood_dep_squashed <- function(x, ..., package = NULL) {
  # Header
  cat("<squashed dependencies>\n")

  # Body
  max_origin_length <- max(nchar(x[["origin"]])) + 2
  for (i in seq_len(nrow(x))) {
    # Origin part
    origin <- x[[i, "origin"]]
    if (i == 1 || origin != x[[i - 1, "origin"]]) {
      cat(format(origin, width = max_origin_length, justify = "left"))
    } else {
      cat(strrep(" ", max_origin_length))
    }
    # Dependency part
    cat(sprintf(
      "%1$-12s %2$s",
      paste0(x[[i, "type"]], ":"),
      x[[i, "package"]]
    ))
    if (!is.na(x[[i, "version"]])) {
      cat(sprintf(" (>= %s)", x[[i, "version"]]))
    }
    cat("\n")
  }
}
