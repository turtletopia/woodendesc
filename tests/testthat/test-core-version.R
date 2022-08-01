utils_version <- wood_core_version("utils")

test_that("returns a single string", {
  expect_vector(utils_version,
                ptype = character(),
                size = 1)
})

test_that("returned string is a version code", {
  expect_version_code(utils_version)
})

test_that("raises an exception if package not available", {
  expect_error(wood_core_version("fakepackage"))
})
