as_wood_deps <- function(df) {
  # Colnames should be "package", "version", and "type", in this order
  if (!identical(colnames(df), c("package", "version", "type")))
    stop("Unexpected set of columns in dependency list.", call. = FALSE)

  structure(
    df,
    class = c("wood_deps", class(df))
  )
}
