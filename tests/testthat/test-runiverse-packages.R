skip_if_not_installed("httptest2")
wood_clear_cache()

# SETUP ----
with_mock_dir("v", {
  tidyverse_packages <- wood_runiverse_packages("tidyverse")
})

# TESTS ----
test_packages(tidyverse_packages)
test_cache({ wood_runiverse_packages(universe = "tidyverse") }, tidyverse_packages)
test_param_runiverse(wood_runiverse_packages(universe = "tidyverse"))

test_that("tidyverse universe has ggplot2 package", {
  expect_subset("ggplot2", tidyverse_packages)
})

test_that("raises an exception if a universe doesn't exist", {
  expect_error(
    wood_runiverse_packages("nonexistent_universe"),
    "Received package list is empty.",
    fixed = TRUE
  )
})
