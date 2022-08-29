# LENGTH ----
assert_length_1 <- function(object, label) {
  len <- length(object)
  if (len != 1) {
    msg <- sprintf("`%s` must have length 1, not %i.", label, len)
    stop(msg, call. = FALSE)
  }
}

assert_not_empty <- function(object, label) {
  if (length(object) == 0) {
    msg <- sprintf("`%s` must not be empty.", label)
    stop(msg, call. = FALSE)
  }
}

# TYPE ----
assert_string <- function(object, label) {
  type <- typeof(object)
  if (type != "character") {
    msg <- sprintf("`%s` must be a character vector, not %s.", label, type)
    stop(msg, call. = FALSE)
  }
}

# MISSING VALUES ----
assert_no_NA <- function(object, label) {
  if (anyNA(object)) {
    locations <- which(is.na(object))
    msg <- sprintf(
      c("`%1$s` must not contain NAs.\n",
        "(i) NAs found at %2$s: %3$s"),
      label,
      ngettext(length(locations), "location", "locations"),
      collapse_comma(locations)
    )
    stop(msg, call. = FALSE)
  }
}
