# SETUP ----
utils_version <- wood_core_version("utils")

# TESTS ----
test_version(utils_version)

test_that("raises an exception if package not available", {
  expect_error(wood_core_version("fakepackage"))
})
