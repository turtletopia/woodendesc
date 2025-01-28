skip_if_not_installed("httptest2")
wood_clear_cache()

# SETUP ----
httptest2::with_mock_api({
  versionsort_deps <- wood_runiverse_dependencies("versionsort", "turtletopia")
})

# TESTS ----
test_dependencies(versionsort_deps)
test_cache({ wood_runiverse_dependencies("versionsort", "turtletopia") }, versionsort_deps)
test_param_package(wood_runiverse_dependencies(package = "versionsort", universe = "turtletopia"))
test_param_runiverse(wood_runiverse_dependencies(package = "versionsort", universe = "turtletopia"))

test_that("raises an exception if package not available", {
  expect_error(
    wood_runiverse_dependencies("fakepackage", "turtletopia"),
    "Can't find package `fakepackage` in universe `turtletopia`.",
    fixed = TRUE
  )
})
