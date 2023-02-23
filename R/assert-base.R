# LENGTH ----
assert_length_1 <- function(object, label) {
  len <- length(object)
  if (len != 1) {
    stopf("`%s` must have length 1, not %i.", label, len)
  }
}

assert_not_empty <- function(object, label) {
  if (length(object) == 0) {
    stopf("`%s` must not be empty.", label)
  }
}

assert_keyword_single <- function(object, label, keywords) {
  if (length(object) > 1 && all(object %in% keywords)) {
    stopf(
      c("`%1$s` must not contain multiple keywords.\n",
        "(i) Vector length is %2$i\n",
        "(i) Keywords must be used as length 1 strings"),
      label,
      length(object)
    )
  }
}

# TYPE ----
assert_string <- function(object, label) {
  type <- typeof(object)
  if (type != "character") {
    stopf("`%s` must be a character vector, not %s.", label, type)
  }
}

assert_logical <- function(object, label) {
  type <- typeof(object)
  if (type != "logical") {
    stopf("`%s` must be a logical vector, not %s.", label, type)
  }
}

# PROPERTIES ----
assert_unique <- function(object, label) {
  if (anyDuplicated(object) > 0) {
    locations <- which(duplicated(object))
    stopf(
      c("`%1$s` must not contain duplicate values.\n",
        "(i) Duplicates found at %2$s: %3$s"),
      label,
      ngettext(length(locations), "location", "locations"),
      collapse_comma(locations)
    )
  }
}

assert_no_NA <- function(object, label) {
  if (anyNA(object)) {
    locations <- which(is.na(object))
    stopf(
      c("`%1$s` must not contain NAs.\n",
        "(i) NAs found at %2$s: %3$s"),
      label,
      ngettext(length(locations), "location", "locations"),
      collapse_comma(locations)
    )
  }
}

# CUSTOM ASSERTIONS ----
assert_all_or_paths <- function(object, label) {
  if (length(object) > 1 && any(object == "all")) {
    locations <- which(object == "all")
    stopf(
      c("`%1$s` must not contain both \"all\" and paths.\n",
        "(i) You can specify either \"all\" or paths, not both\n",
        "(i) \"all\" found at %2$s: %3$s\n",
        "(i) Vector length is %4$i"),
      label,
      ngettext(length(locations), "location", "locations"),
      collapse_comma(locations),
      length(object)
    )
  }
}

assert_dirs_exist <- function(object, label) {
  # Skip test for "all" keyword
  if (!identical(object, "all")) {
    missing_dirs <- which(!dir.exists(object))
    if (any(missing_dirs)) {
      stopf(
        c("`%1$s` must contain only valid paths.\n",
          "(i) Invalid paths found at %2$s: %3$s\n"),
        label,
        ngettext(length(missing_dirs), "location", "locations"),
        collapse_comma(missing_dirs)
      )
    }
  }
}

assert_keyword_or_release <- function(object, label) {
  if (!object %in% c("release", "devel") &&
      !grepl("^\\d+\\.\\d+$", object, perl = TRUE)) {
    stopf(
      c("`%1$s` must be a valid Bioconductor release code.\n",
        "(i) Received value is \"%2$s\"\n",
        "(i) Valid codes are two number separated by a dot\n",
        "(i) Alternatively, you can use \"release\" or \"devel\" keywords"),
      label,
      object
    )
  }
}

assert_keyword_or_dep_type <- function(object, label) {
  keywords <- c("all", "most", "strong")

  if (any(!object %in% c(.DEPENDENCY_TYPES, keywords))) {
    locations <- which(!object %in% c(.DEPENDENCY_TYPES, keywords))
    stopf(
      c("`%1$s` must contain valid dependency types.\n",
        "(i) Found illegal strings at %2$s: %3$s\n",
        "(i) Valid types are: %4$s\n",
        "(i) Alternatively, use one of these keywords: %5$s"),
      label,
      ngettext(length(locations), "location", "locations"),
      collapse_comma(locations),
      collapse_comma(.DEPENDENCY_TYPES, truncate_at = Inf),
      collapse_comma(keywords, truncate_at = Inf)
    )
  }

  if (length(object) > 1 && any(object %in% keywords)) {
    locations <- which(object %in% keywords)
    stopf(
      c("`%1$s` must not mix dependency types and keywords.\n",
        "(i) Found keywords at %2$s: %3$s\n",
        "(i) Valid dependency types are: %4$s"),
      label,
      ngettext(length(locations), "location", "locations"),
      collapse_comma(locations),
      collapse_comma(.DEPENDENCY_TYPES, truncate_at = Inf)
    )
  }
}
