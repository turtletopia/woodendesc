# SETUP ----
utils_version <- wood_core_version("utils")

# TESTS ----
test_version(utils_version)
test_param_package(wood_core_version(package = "utils"))

test_that("raises an exception if package not available", {
  expect_error(
    wood_core_version("fakepackage"),
    "`package` must be one of R core packages.",
    fixed = TRUE
  )
})
