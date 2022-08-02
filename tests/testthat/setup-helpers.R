expect_pkg_name <- function(object) {
  expect_match(
    object,
    paste0("^R|(", .standard_regexps()$valid_package_name, ")$")
  )
}

expect_version_code <- function(object) {
  expect_match(
    object,
    paste0("^", .standard_regexps()$valid_numeric_version, "$")
  )
}

expect_bioc_release_code <- function(object) {
  expect_match(object, "^\\d+\\.\\d+$")
}

expect_dependency_type <- function(object) {
  expect_subset(
    object,
    c("Depends", "Imports", "Suggests", "LinkingTo", "Enhances")
  )
}

expect_not_empty <- function(object) {
  expect_gt(length(object), 0)
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
