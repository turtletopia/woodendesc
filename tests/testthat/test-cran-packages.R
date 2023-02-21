skip_if_not_installed("vcr")
skip("Decompression issue")
wood_clear_cache()

# SETUP ----
vcr::use_cassette("cran-packages", {
  cran_packages <- wood_cran_packages()
})

# TESTS ----
test_packages(cran_packages)
test_cache(wood_cran_packages, cran_packages)

test_that("there's a ggplot2 package in the list", {
  expect_subset("ggplot2", cran_packages)
})
