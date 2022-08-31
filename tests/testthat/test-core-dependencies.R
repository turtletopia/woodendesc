# SETUP ----
stats_deps <- wood_core_dependencies("stats")

# TESTS ----
test_dependencies(stats_deps)
test_param_package(wood_core_dependencies)

test_that("raises an exception if package not available", {
  expect_error(
    wood_core_dependencies("fakepackage"),
    "`package` must be one of R core packages.",
    fixed = TRUE
  )
})

# TODO: test datasets package since it has no dependencies
