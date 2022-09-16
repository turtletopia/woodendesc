skip_if_not_installed("vcr")
wood_clear_cache()

# SETUP ----
vcr::use_cassette("versionsort-version-tt", {
  versionsort_version <- wood_runiverse_version("versionsort", "turtletopia")
})

# TESTS ----
test_version(versionsort_version)
test_cache(
  wood_runiverse_version, versionsort_version, "versionsort", "turtletopia"
)
test_param_package(wood_runiverse_version, universe = "turtletopia")
test_param_runiverse(wood_runiverse_version, package = "versionsort")

vcr::use_cassette("runiverse-fakepackage-version", {
  test_that("raises an exception if package not available", {
    expect_error(
      wood_runiverse_dependencies("fakepackage", "turtletopia"),
      "Can't find package `fakepackage` in universe `turtletopia`.",
      fixed = TRUE
    )
  })
})
