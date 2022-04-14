skip_if_not_installed("vcr")

# SETUP ----
vcr::use_cassette("cran-packages", {
  cran_packages <- wood_cran_packages()
})

# TESTS ----
test_that("returns a vector of strings", {
  expect_vector(cran_packages,
                ptype = character())
})

test_that("returned vector of strings is not empty", {
  expect_gt(length(cran_packages), 0)
})

test_that("all returned strings are valid package names", {
  expect_pkg_name(cran_packages)
})

test_that("there's a ggplot2 package in the list", {
  expect_subset("ggplot2", cran_packages)
})

test_that("if possible, reads from cache", {
  expect_cache(wood_cran_packages, cran_packages)
})
