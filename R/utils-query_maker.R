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
