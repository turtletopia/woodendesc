skip_if_not_installed("vcr")

# SETUP ----
# Re-record on older R versions since it queries for PACKAGES without .gz
vcr::use_cassette("omegahat-packages", {
  omegahat_packages <- wood_url_packages("http://www.omegahat.net/R")
}, record = "new_episodes")

# TESTS ----
test_packages(omegahat_packages, wood_url_packages, "http://www.omegahat.net/R")

test_that("Omega repository has RGraphicsDevice package", {
  expect_subset("RGraphicsDevice", omegahat_packages)
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
