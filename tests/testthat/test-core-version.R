utils_version <- wood_core_version("utils")

test_version(utils_version, wood_core_version, "utils", .test_cache = FALSE)

test_that("raises an exception if package not available", {
  expect_error(wood_core_version("fakepackage"))
})
