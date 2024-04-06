skip_if_not_installed("httptest2")
wood_clear_cache()

# SETUP ----
with_mock_dir("cran-packages", {
  cran_packages <- wood_cran_packages()
})

# TESTS ----
test_packages(cran_packages)
test_cache(wood_cran_packages, cran_packages)

test_that("there's a ggplot2 package in the list", {
  expect_subset("ggplot2", cran_packages)
})
