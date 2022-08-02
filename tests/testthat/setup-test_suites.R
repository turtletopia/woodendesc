test_cache <- function(tested_function, expected_value, ...) {
  test_that("if possible, reads from cache", {
    expect_cache(tested_function, expected_value, ...)
  })
}

test_packages <- function(packages) {
  test_that("returns a vector of strings", {
    expect_vector(packages,
                  ptype = character())
  })

  test_that("returned vector of strings is not empty", {
    expect_gt(length(packages), 0)
  })

  test_that("all returned strings are valid package names", {
    expect_pkg_name(packages)
  })
}

test_version <- function(version) {
  test_that("returns a single string", {
    expect_vector(version,
                  ptype = character(),
                  size = 1)
  })

  test_that("returned string is a version code", {
    expect_version_code(version)
  })
}

test_dependencies <- function(deps) {
  test_that("returns a data frame with package, version & type columns", {
    expect_vector(deps,
                  ptype = data.frame(
                    package = character(),
                    version = character(),
                    type = character(),
                    stringsAsFactors = FALSE
                  ))
  })

  test_that("returned 'package' column contains package names", {
    expect_pkg_name(deps[["package"]])
  })

  test_that("returned 'version' column contains version codes or NA values", {
    versions <- omit_na(deps[["version"]])
    if (length(versions) == 0) {
      expect_equal(versions, character())
    } else {
      expect_version_code(versions)
    }
  })

  test_that("returned 'type' column contains dependency types", {
    expect_dependency_type(deps[["type"]])
  })
}
