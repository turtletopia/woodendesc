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
