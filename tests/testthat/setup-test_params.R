test_param_package <- function(tested_function, ...) {
  test_that("`package` must be a character vector", {
    expect_error(
      tested_function(package = 1, ...),
      "`package` must be a character vector, not .*"
    )
    expect_error(
      tested_function(package = list(), ...),
      "`package` must be a character vector, not .*"
    )
  })

  test_that("`package` must have length 1", {
    expect_error(
      tested_function(package = letters, ...),
      sprintf("`package` must have length 1, not %i.", length(letters)),
      fixed = TRUE
    )
  })

  test_that("`package` must not be NA", {
    expect_error(
      tested_function(package = NA_character_, ...),
      "`package` must not contain NAs.",
      fixed = TRUE
    )
  })
}
