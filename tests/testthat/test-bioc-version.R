skip_if_not_installed("vcr")
wood_clear_cache()

# SETUP ----
vcr::use_cassette("affy-version", {
  affy_version <- wood_bioc_version("affy")
}, record = "new_episodes")

# TESTS ----
test_version(affy_version, wood_bioc_version, "affy")

test_that("raises an exception if package not available", {
  vcr::use_cassette("bioc-fakepackage-version", {
    expect_error(wood_bioc_version("fakepackage", release = "3.14"))
  }, record = "new_episodes")
})

test_that("correctly retrieves data from older releases", {
  vcr::use_cassette("affy-version-old", {
    affy_version_old <- wood_bioc_version("affy", release = "1.5")
  }, record = "new_episodes")

  expect_equal(affy_version_old, "1.5.8-1")
})
