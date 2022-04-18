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
