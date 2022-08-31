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

assert_keyword_single <- function(object, label, keywords) {
  if (length(object) > 1 && all(object %in% keywords)) {
    msg <- sprintf(
      c("`%1$s` must not contain multiple keywords.\n",
        "(i) Vector length is %2$i\n",
        "(i) Keywords must be used as length 1 strings"),
      label,
      length(object)
    )
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

assert_logical <- function(object, label) {
  type <- typeof(object)
  if (type != "logical") {
    msg <- sprintf("`%s` must be a logical vector, not %s.", label, type)
    stop(msg, call. = FALSE)
  }
}

# PROPERTIES ----
assert_unique <- function(object, label) {
  if (anyDuplicated(object) > 0) {
    locations <- which(duplicated(object))
    msg <- sprintf(
      c("`%1$s` must not contain duplicate values.\n",
        "(i) Duplicates found at %2$s: %3$s"),
      label,
      ngettext(length(locations), "location", "locations"),
      collapse_comma(locations)
    )
    stop(msg, call. = FALSE)
  }
}

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

# CUSTOM ASSERTIONS ----
assert_all_or_paths <- function(object, label) {
  if (length(object) > 1 && any(object == "all")) {
    locations <- which(object == "all")
    msg <- sprintf(
      c("`%1$s` must not contain both \"all\" and paths.\n",
        "(i) You can specify either \"all\" or paths, not both\n",
        "(i) \"all\" found at %2$s: %3$s\n",
        "(i) Vector length is %4$i"),
      label,
      ngettext(length(locations), "location", "locations"),
      collapse_comma(locations),
      length(object)
    )
    stop(msg, call. = FALSE)
  }
}

assert_keyword_or_release <- function(object, label) {
  if (!object %in% c("release", "devel") &&
      !grepl("^\\d+\\.\\d+$", object, perl = TRUE)) {
    msg <- sprintf(
      c("`%1$s` must be a valid Bioconductor release code.\n",
        "(i) Received value is \"%2$s\"\n",
        "(i) Valid codes are two number separated by a dot\n",
        "(i) Alternatively, you can use \"release\" or \"devel\" keywords"),
      label,
      object
    )
    stop(msg, call. = FALSE)
  }
}

assert_keyword_or_dep_type <- function(object, label) {
  dep_types <- c("Depends", "Imports", "LinkingTo", "Suggests", "Enhances")
  keywords <- c("all", "most", "strong")

  if (any(!object %in% c(dep_types, keywords))) {
    locations <- which(!object %in% c(dep_types, keywords))
    msg <- sprintf(
      c("`%1$s` must contain valid dependency types.\n",
        "(i) Found illegal strings at %2$s: %3$s\n",
        "(i) Valid types are: %4$s\n",
        "(i) Alternatively, use one of these keywords: %5$s"),
      label,
      ngettext(length(locations), "location", "locations"),
      collapse_comma(locations),
      collapse_comma(dep_types, truncate_at = Inf),
      collapse_comma(keywords, truncate_at = Inf)
    )
    stop(msg, call. = FALSE)
  }

  if (length(object) > 1 && any(object %in% keywords)) {
    locations <- which(object %in% keywords)
    msg <- sprintf(
      c("`%1$s` must not mix dependency types and keywords.\n",
        "(i) Found keywords at %2$s: %3$s\n",
        "(i) Valid dependency types are: %4$s"),
      label,
      ngettext(length(locations), "location", "locations"),
      collapse_comma(locations),
      collapse_comma(dep_types, truncate_at = Inf)
    )
    stop(msg, call. = FALSE)
  }
}
