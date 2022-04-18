skip_if_not_installed("vcr")

# SETUP ----
# Re-record on older R versions since it queries for PACKAGES without .gz
vcr::use_cassette("omegahat-packages", {
  omegahat_packages <- wood_url_packages("http://www.omegahat.net/R")
}, record = "new_episodes")

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

vcr::use_cassette("cynkra-slashes", {
  test_that("trailing slash is removed from url parameter", {
    expect_no_error(wood_url_packages("https://cynkra.r-universe.dev/"))
  })
}, record = "new_episodes")

vcr::use_cassette("colinfay-packages", {
  test_that("url_packages() uses PACKAGES if PACKAGES.gz is not available", {
    expect_no_error(wood_url_packages("https://colinfay.me"))
  })
}, record = "new_episodes")
