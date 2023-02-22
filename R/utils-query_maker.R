query_maker <- function(type, context, ...) {
  structure(
    list(
      func = find_function(type, context),
      args = list(...)
    ),
    class = "wood_query_maker"
  )
}

add_parameter <- function(object, value, label, value_transform = identity) {
  UseMethod("add_parameter")
}

add_parameter.wood_query_maker <- function(object, value, label,
                                           value_transform = identity) {
  if (length(value) > 0) {
    object[["args"]][[label]] <- value_transform(value)
  }
  object
}

make_query <- function(object, ...) {
  UseMethod("make_query")
}

make_query.wood_query_maker <- function(object, ...) {
  do.call(object[["func"]], c(..., object[["args"]]))
}

#' Find first working repository
#'
#' @description This function returns information from the first repository
#' that works with the specified parameters (e.g. `package = "Biostrings"`).
#'
#' @param query_makers `wood_query_maker()`\cr
#'  Repositories with their handlers.
#' @param ... `ANY`\cr
#'  Additional parameters for queries.
#'
#' @return Return value from the first working repository.
#'
#' @noRd
try_repos <- function(query_makers, ...) {
  for (query_maker in query_makers) {
    try({
      return(make_query(query_maker, ...))
    }, silent = TRUE)
  }
}

#' Collect data from all repositories
#'
#' @description This function collects character vectors from all specified
#' repos and removes duplicate values.
#'
#' @param query_makers `wood_query_maker()`\cr
#'  Repositories with their handlers.
#' @param ... `ANY`\cr
#'  Additional parameters for queries.
#'
#' @return A character vector of unique values.
#'
#' @noRd
collect_repos <- function(query_makers, ...) {
  Reduce(function(values, query_maker) {
    tryCatch({
      values <- union(values, make_query(query_maker, ...))
    }, error = function(e) values)
  }, query_makers, init = character())
}
