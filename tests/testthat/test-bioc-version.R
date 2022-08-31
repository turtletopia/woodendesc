skip_if_not_installed("vcr")
wood_clear_cache()

# SETUP ----
vcr::use_cassette("affy-version", {
  affy_version <- wood_bioc_version("affy")
}, record = "new_episodes")

# TESTS ----
test_version(affy_version)
test_cache(wood_bioc_version, affy_version, "affy")
test_param_package(wood_bioc_version)
test_param_bioc_release(wood_bioc_version, package = "affy")

vcr::use_cassette("bioc-fakepackage-version", {
  test_that("raises an exception if package not available", {
    expect_error(
      wood_bioc_version("fakepackage", release = "3.14"),
      "Can't find package `fakepackage` in Bioconductor release `3.14`.",
      fixed = TRUE
    )
  })
}, record = "new_episodes")

vcr::use_cassette("affy-version-old", {
  test_that("correctly retrieves data from older releases", {
    affy_version_old <- wood_bioc_version("affy", release = "1.5")
    expect_equal(affy_version_old, "1.5.8-1")
  })
}, record = "new_episodes")
