skip_if_not_installed("vcr")

# SETUP ----
vcr::use_cassette("omegahat-packages", {
  omegahat_packages <- wood_url_packages("http://www.omegahat.net/R")
})

# TESTS ----
test_that("returns a vector of strings", {
  expect_vector(omegahat_packages,
                ptype = character())
})

test_that("returned vector of strings is not empty", {
  expect_gt(length(omegahat_packages), 0)
})

test_that("all returned strings are valid package names", {
  expect_pkg_name(omegahat_packages)
})

test_that("Omega repository has RGraphicsDevice package", {
  expect_subset("RGraphicsDevice", omegahat_packages)
})

test_that("if possible, reads from cache", {
  expect_cache(wood_url_packages, omegahat_packages, "http://www.omegahat.net/R")
})
