read_dcf <- function(object) {
  # Split into packages
  packages <- strsplit(object, "\\n\\n")[[1]]
  # Split into lines, each line being Key: Values
  packages <- strsplit(packages, "\\n")
  # Extract field names
  packages <- lapply(packages, function(p_data) {
    # Extract field names and field values as separate strings
    split_data <- regmatches(p_data, regexpr(": ", p_data), invert = TRUE)
    # Field names are first values in lists, values are second
    ret <- lapply(split_data, `[[`, 2)
    # Don't parse values until necessary
    setNames(ret, vapply(split_data, `[[`, character(1), 1))
  })
  setNames(packages, vapply(packages, `[[`, character(1), "Package"))
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
