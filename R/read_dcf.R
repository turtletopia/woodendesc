read_dcf <- function(object) {
  # Split into packages
  packages <- strsplit(object, "\r?\n\r?\n")[[1]]

  # Split into lines, each line being Key: Values
  # Some fields are newlines
  if (.Platform$OS.type != "windows") {
    # Use lookahead to match and not strip Key characters
    # As long as there are no Values with ":" in second or later line it will work
    packages <- strsplit(packages, "\r?\n(?=[^\n]*: )", perl = TRUE)
  } else {
    # Seems like lookahead may not work on Windows sometimes
    packages <- gsub("\r?\n([^\n]+: )", "\n@\\1", packages)
    packages <- strsplit(packages, "\r?\n@")
  }

  # Extract field names
  packages <- lapply(packages, function(p_data) {
    # Extract field names and field values as separate strings
    split_data <- regmatches(p_data, regexpr(": ", p_data), invert = TRUE)
    # Field names are first values in lists, values are second
    ret <- lapply(split_data, `[[`, 2)
    # Don't parse values until necessary
    names(ret) <- vapply(split_data, `[[`, character(1), 1)
    ret
  })
  names(packages) <- vapply(packages, `[[`, character(1), "Package")
  packages
}

read_dcf_packages <- function(object) {
  if (R_older_than("4.1.0")) {
    # gregexec was introduced in 4.1.0
    matches <- regmatches(
      object,
      gregexpr("Package: (\\S+)", object)
    )
    unique(substring(matches[[1]], first = 10))
  } else {
    matches <- regmatches(
      object,
      gregexec("Package: (\\S+)", object)
    )
    unique(matches[[1]][2, ])
  }
}
