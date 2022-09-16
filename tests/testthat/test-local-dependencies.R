# SETUP ----
woodendesc_deps <- wood_local_dependencies("woodendesc")

# TESTS ----
test_dependencies(woodendesc_deps)
test_param_package(wood_local_dependencies)
test_param_paths(wood_local_dependencies, package = "woodendesc")

test_that("raises an exception if package not available", {
  expect_error(wood_local_dependencies("fakepackage"))
})

test_that("raises an exception if package not found", {
  expect_error(
    wood_local_dependencies("fakepackage"),
    "Can't find package `fakepackage` in the specified paths.",
    fixed = TRUE
  )
})
