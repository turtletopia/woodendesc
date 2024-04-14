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

expect_cache <- function(expression, expected) {
  # If the function reads from cache, it means that it will work offline
  httptest2::without_internet({
    httptest2::expect_no_request({
      result_from_cache <- force(expression)
    })

    expect_identical(result_from_cache, expected)
  })
}
