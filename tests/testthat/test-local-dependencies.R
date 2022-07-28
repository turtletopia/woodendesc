# SETUP ----
woodendesc_deps <- wood_local_dependencies("woodendesc")

# TESTS ----
test_dependencies(woodendesc_deps, wood_local_dependencies, .test_cache = FALSE)

test_that("raises an exception if package not available", {
  expect_error(wood_local_dependencies("fakepackage"))
})
