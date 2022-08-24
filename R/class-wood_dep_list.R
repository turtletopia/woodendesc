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

#' @export
squash <- function(object) {
  UseMethod("squash")
}

#' @rdname squash
#' @export
squash.wood_dep_list <- function(object) {
  # Filter out empty and NULL dependencies
  deps <- object[!vapply(object, is.null, logical(1))]
  deps <- deps[lengths(deps) > 0]
  # Add origin column
  deps <- mapply(cbind, origin = names(deps), deps, SIMPLIFY = FALSE)
  # Merge data frames
  do.call(rbind, c(deps, make.row.names = FALSE))
}
