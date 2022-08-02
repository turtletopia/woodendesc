# SETUP ----
stats_deps <- wood_core_dependencies("stats")

# TESTS ----
test_dependencies(stats_deps)

test_that("raises an exception if package not available", {
  expect_error(wood_core_dependencies("fakepackage"))
})
