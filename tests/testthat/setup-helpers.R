expect_pkg_name <- function(object) {
  expect_match(
    object, "^[^\\W\\d_]([^\\W_]|\\.)*[^\\W_]$", perl = TRUE
  )
}

expect_version_code <- function(object) {
  # Matches standard version codes with "major.minor.patch" naming schema
  expect_match(object, "\\d+\\.\\d+\\.\\d+")
}

expect_subset <- function(object, expected) {
  expect_true(all(object %in% expected))
}

expect_no_error <- function(object) {
  expect_error(object, regexp = NA)
}

expect_cache <- function(tested_function, expected, ...) {
  skip_if_not_installed("httptest")

  # TODO: simplify once httptest::expect_no_request() works with httr again
  # If the function reads from cache, it means that it will work offline
  expect_no_error({
    httptest::without_internet(
      result_from_cache <- tested_function(...)
    )
  })
  expect_identical(result_from_cache, expected)
}
