test_packages <- function(packages, tested_function, ...) {
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

  test_that("if possible, reads from cache", {
    expect_cache(tested_function, packages, ...)
  })
}

test_version <- function(version, tested_function, ...) {
  test_that("returns a single string", {
    expect_vector(version,
                  ptype = character(),
                  size = 1)
  })

  test_that("returned string is a version code", {
    expect_version_code(version)
  })

  test_that("if possible, reads from cache", {
    expect_cache(tested_function, version, ...)
  })
}
