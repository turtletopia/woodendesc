skip_if_not_installed("vcr")
wood_clear_cache()

# SETUP ----
vcr::use_cassette("RGD-version", {
  RGD_version <- wood_url_version(
    "RGraphicsDevice", "http://www.omegahat.net/R"
  )
}, record = "new_episodes")

# TESTS ----
test_version(
  RGD_version, wood_url_version, "RGraphicsDevice", "http://www.omegahat.net/R"
)

test_that("raises an exception if package not available", {
  expect_error(wood_url_version("fakepackage", "http://www.omegahat.net/R"))
})
