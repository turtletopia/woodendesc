skip_if_not_installed("httptest2")
wood_clear_cache()

# SETUP ----
httptest2::with_mock_api({
  cran_packages <- wood_cran_packages()
})

# TESTS ----
test_packages(cran_packages)
test_cache({ wood_cran_packages() }, cran_packages)

test_that("there's an abc package in the list", {
  expect_subset("abc", cran_packages)
})
