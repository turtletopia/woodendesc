expect_pkg_name <- function(object) {
  expect_match(
    object, "^[^\\W\\d_]([^\\W_]|\\.)*[^\\W_]$", perl = TRUE
  )
}

expect_version_code <- function(object) {
  # Matches standard version codes with "major.minor.patch" naming schema
  expect_match(object, "\\d+\\.\\d+\\.\\d+")
}
