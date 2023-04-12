as_wood_dep_squashed <- function(df) {
  # Colnames should be "origin", "package", "version", and "type"; in this order
  if (!identical(colnames(df), c("origin", "package", "version", "type")))
    stop("Unexpected set of columns in squashed dependency list.", call. = FALSE)

  structure(
    df,
    class = c("wood_dep_squashed", class(df))
  )
}

# nocov start
#' @export
print.wood_dep_squashed <- function(x, ...) {
  # Header
  cat("<squashed dependencies>\n")

  if (nrow(x) == 0) {
    return()
  }
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

#' @export
summary.wood_dep_squashed <- function(object, ...) {
  # Revert squash()
  object <- split(object[, -1], object[["origin"]])
  object <- lapply(object, as_wood_deps)
  object <- as_wood_dep_list(object)
  # Call summary of wood_dep_list()
  summary(object)
}
# nocov end
