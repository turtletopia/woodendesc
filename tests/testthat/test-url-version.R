skip_if_not_installed("vcr")
wood_clear_cache()

# SETUP ----
vcr::use_cassette("RGD-version", {
  RGD_version <- wood_url_version(
    "RGraphicsDevice", "http://www.omegahat.net/R"
  )
}, record = "new_episodes")

# TESTS ----
test_version(RGD_version)
test_cache(
  wood_url_version, RGD_version, "RGraphicsDevice", "http://www.omegahat.net/R"
)
test_param_package(wood_url_version, repository = "http://www.omegahat.net/R")
test_param_url_repo(wood_url_version, package = "RGraphicsDevice")

test_that("raises an exception if package not available", {
  expect_error(
    wood_url_version("fakepackage", "http://www.omegahat.net/R"),
    "Can't find package `fakepackage` on repository http://www.omegahat.net/R.",
    fixed = TRUE
  )
})
