skip_if_not_installed("httptest2")
wood_clear_cache()

# SETUP ----
with_mock_dir("w", {
  versionsort_version <- wood_runiverse_version("versionsort", "turtletopia")
})

# TESTS ----
test_version(versionsort_version)
test_cache({ wood_runiverse_version("versionsort", "turtletopia") }, versionsort_version)
test_param_package(wood_runiverse_version(package = "versionsort", universe = "turtletopia"))
test_param_runiverse(wood_runiverse_version(package = "versionsort", universe = "turtletopia"))

test_that("raises an exception if package not available", {
  expect_error(
    wood_runiverse_dependencies("fakepackage", "turtletopia"),
    "Can't find package `fakepackage` in universe `turtletopia`.",
    fixed = TRUE
  )
})
