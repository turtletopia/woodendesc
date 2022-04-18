skip_if_not_installed("vcr")

# SETUP ----
vcr::use_cassette("cran-packages", {
  cran_packages <- wood_cran_packages()
})

# TESTS ----
test_packages(cran_packages, wood_cran_packages)

test_that("there's a ggplot2 package in the list", {
  expect_subset("ggplot2", cran_packages)
})
