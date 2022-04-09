skip_if_not_installed("vcr")

vcr::use_cassette("ropensci-packages", {
  ropensci_packages <- wood_runiverse_packages()
})

test_that("returns a vector of strings", {
  expect_vector(ropensci_packages,
                ptype = character())
})

test_that("returned vector of strings is not empty", {
  expect_gt(length(ropensci_packages), 0)
})

test_that("all returned strings are valid package names", {
  expect_pkg_name(ropensci_packages)
})

test_that("tidyverse universe has ggplot2 package", {
  vcr::use_cassette("tidyverse-packages", {
    expect_true("ggplot2" %in% wood_runiverse_packages("tidyverse"))
  })
})

test_that("if a universe doesn't exist, returns an empty character vector with a warning", {
  vcr::use_cassette("nonexistent-packages", {
    expect_warning(
      nonexistent_packages <- wood_runiverse_packages("nonexistent_universe")
    )
    expect_equal(nonexistent_packages, character())
  })
})
