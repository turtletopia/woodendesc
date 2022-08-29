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

test_param_runiverse <- function(tested_function, ...) {
  test_that("`universe` must be a character vector", {
    expect_error(
      tested_function(universe = 1, ...),
      "`universe` must be a character vector, not .*"
    )
    expect_error(
      tested_function(universe = list(), ...),
      "`universe` must be a character vector, not .*"
    )
  })

  test_that("`universe` must have length 1", {
    expect_error(
      tested_function(universe = letters, ...),
      sprintf("`universe` must have length 1, not %i.", length(letters)),
      fixed = TRUE
    )
  })

  test_that("`universe` must not be NA", {
    expect_error(
      tested_function(universe = NA_character_, ...),
      "`universe` must not contain NAs.",
      fixed = TRUE
    )
  })
}

test_param_paths <- function(tested_function, ...) {
  test_that("`paths` must be a character vector", {
    expect_error(
      tested_function(paths = 1, ...),
      "`paths` must be a character vector, not .*"
    )
    expect_error(
      tested_function(paths = list(), ...),
      "`paths` must be a character vector, not .*"
    )
  })

  test_that("`paths` must not be empty", {
    expect_error(
      tested_function(paths = character(), ...),
      "`paths` must not be empty.",
      fixed = TRUE
    )
  })

  test_that("`paths` must not be NA", {
    expect_error(
      tested_function(paths = c(letters, NA_character_), ...),
      "`paths` must not contain NAs.",
      fixed = TRUE
    )
  })

  test_that("`paths` cannot contain \"all\" mixed with paths", {
    expect_error(
      tested_function(paths = c("all", letters), ...),
      "`paths` must not contain both \"all\" and paths.",
      fixed = TRUE
    )
  })
}
