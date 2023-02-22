#' Parse DCF file to list
#'
#' @description Takes a single string with newlines and returns a list of lists
#' for each package.
#'
#' @param object `character(1)`\cr
#'  Contents of a file to parse in a form of a single string.
#'
#' @return A list with one element for each package; each element being a list
#' of fields, each field in the form of a single string.
#'
#' @noRd
read_dcf <- function(object) {
  # Split into packages
  packages <- strsplit(object, "\r?\n\r?\n")[[1]]

  # Split into lines, each line being Key: Values
  # Some fields are newlines
  # Use lookahead to match and not strip Key characters
  # As long as there are no Values with ":" in second or later line it will work
  packages <- strsplit(packages, "\r?\n(?=[^\n]*: )", perl = TRUE)

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

#' Extract all values of a field from DCF file
#'
#' @description Scans a string in search of certain field, then extracts all
#' encountered values.
#'
#' @param object `character(1)`\cr
#'  Contents of a file to parse in a form of a single string.
#' @param field `character(1)`\cr
#'  Name of a field to look for.
#'
#' @return A character vector, each element being an extracted value.
#'
#' @noRd
read_dcf_all_values <- function(object, field) {
  if (getRversion() >= "4.1.0") {
    matches <- regmatches(
      object,
      gregexec(paste0(field, ": (\\S+)"), object)
    )
    unique(matches[[1]][2, ])
  } else {
    # gregexec was introduced in 4.1.0
    matches <- regmatches(
      object,
      gregexpr(paste0(field, ": (\\S+)"), object)
    )
    unique(substring(matches[[1]], first = 10))
  }
}

#' Extract first value of a field from DCF file
#'
#' @description Scans a string in search of certain field, then extracts the
#' first encountered value.
#'
#' @param object `character(1)`\cr
#'  Contents of a file to parse in a form of a single string.
#' @param field `character(1)`\cr
#'  Name of a field to look for.
#'
#' @return A single string with an extracted value.
#'
#' @noRd
read_dcf_one_value <- function(object, field) {
  regmatches(
    object,
    regexec(paste0(field, ": (\\S+)"), object)
  )[[1]][2]
}

read_char <- function(path) {
  # A wrapper for readChar that reads whole file
  readChar(path, nchars = file.info(path)[["size"]])
}
