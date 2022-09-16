skip_if_not_installed("vcr")
wood_clear_cache()

# SETUP ----
vcr::use_cassette("ropensci-packages", {
  ropensci_packages <- wood_runiverse_packages()
})
vcr::use_cassette("tidyverse-packages", {
  tidyverse_packages <- wood_runiverse_packages("tidyverse")
})

# TESTS ----
test_packages(ropensci_packages)
test_cache(wood_runiverse_packages, ropensci_packages, "ropensci")
test_param_runiverse(wood_runiverse_packages)

test_that("tidyverse universe has ggplot2 package", {
  expect_subset("ggplot2", tidyverse_packages)
})

test_that("if a universe doesn't exist, returns an empty character vector with a warning", {
  vcr::use_cassette("nonexistent-packages", {
    expect_warning(
      nonexistent_packages <- wood_runiverse_packages("nonexistent_universe"),
      "Received package list is empty.",
      fixed = TRUE
    )
  })
  expect_equal(nonexistent_packages, character())
})
