skip_if_not_installed("vcr")
wood_clear_cache()

# SETUP ----
# Re-record on older R versions since it queries for PACKAGES without .gz
vcr::use_cassette("omegahat-packages", {
  omegahat_packages <- wood_url_packages("http://www.omegahat.net/R")
}, record = "new_episodes")

# TESTS ----
test_packages(omegahat_packages)
test_cache(wood_url_packages, omegahat_packages, "http://www.omegahat.net/R")
test_param_url_repo(wood_url_packages)

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

test_that("trailing slash url and without one share the same cache", {
  expect_cache(wood_url_packages, omegahat_packages, "http://www.omegahat.net/R/")
})
