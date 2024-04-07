skip_if_not_installed("httptest2")
wood_clear_cache()

# SETUP ----
with_mock_dir("u", {
  ggplot2_deps <- wood_runiverse_dependencies("ggplot2", "tidyverse")
})

# TESTS ----
test_dependencies(ggplot2_deps)
test_cache(wood_runiverse_dependencies, ggplot2_deps, "ggplot2", "tidyverse")
test_param_package(wood_runiverse_dependencies, universe = "tidyverse")
test_param_runiverse(wood_runiverse_dependencies, package = "ggplot2")

test_that("raises an exception if package not available", {
  expect_error(
    wood_runiverse_dependencies("fakepackage", "turtletopia"),
    "Can't find package `fakepackage` in universe `turtletopia`.",
    fixed = TRUE
  )
})
