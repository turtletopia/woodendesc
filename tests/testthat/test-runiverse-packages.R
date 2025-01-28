skip_if_not_installed("httptest2")
wood_clear_cache()

# SETUP ----
httptest2::with_mock_api({
  turtletopia_packages <- wood_runiverse_packages("turtletopia")
})

# TESTS ----
test_packages(turtletopia_packages)
test_cache({ wood_runiverse_packages(universe = "turtletopia") }, turtletopia_packages)
test_param_runiverse(wood_runiverse_packages(universe = "turtletopia"))

test_that("turtletopia universe has versionsort package", {
  expect_subset("versionsort", turtletopia_packages)
})

test_that("raises an exception if a universe doesn't exist", {
  expect_error(
    wood_runiverse_packages("nonexistent_universe"),
    "Received package list is empty.",
    fixed = TRUE
  )
})
