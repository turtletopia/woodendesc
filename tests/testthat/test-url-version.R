skip_if_not_installed("vcr")
wood_clear_cache()

# SETUP ----
vcr::use_cassette("RGD-version", {
  RGD_version <- wood_url_version(
    "RGraphicsDevice", "http://www.omegahat.net/R"
  )
}, record = "new_episodes")

# TESTS ----
test_that("returns a single string", {
  expect_vector(RGD_version,
                ptype = character(),
                size = 1)
})

test_that("returned string is a version code", {
  expect_match(RGD_version, "\\d+\\.\\d+\\-\\d+")
})

test_that("if possible, reads from cache", {
  expect_cache(wood_url_version, RGD_version,
               package = "RGraphicsDevice",
               repository = "http://www.omegahat.net/R")
})
