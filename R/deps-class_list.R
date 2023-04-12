as_wood_dep_list <- function(object) {
  # All elements should be wood_deps objects or NULL
  if(!all(vapply(object, inherits, logical(1), "wood_deps") |
          vapply(object, is.null, logical(1))))
    stop("Not all objects are `wood_deps`.", call. = FALSE)

  structure(
    object,
    class = c("wood_dep_list", class(object))
  )
}

# nocov start
#' @export
print.wood_dep_list <- function(x, ...) {
  cat(sprintf("<woodendesc dependency list [%s]>\n", length(x)))
  for (pkg in names(x)) {
    print(x[[pkg]], package = pkg)
    cat("\n")
  }
}

#' @export
summary.wood_dep_list <- function(object, ...) {
  lapply(object, summary)
}
# nocov end
