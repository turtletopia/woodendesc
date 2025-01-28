skip_if_not_installed("httptest2")
wood_clear_cache()

# SETUP ----
httptest2::with_mock_api({
  bioc_packages <- wood_bioc_packages()
})

# TESTS ----
test_packages(bioc_packages)
test_cache({ wood_bioc_packages() }, bioc_packages)
test_param_bioc_release(wood_bioc_packages())

test_that("there's an acde package in the list", {
  expect_subset("acde", bioc_packages)
})

test_that("works with older releases", {
  httptest2::with_mock_api({
    bioc_packages_old <- wood_bioc_packages(release = "1.8")
  })
  expect_subset(c("affy", "Biostrings", "impute", "RMAGEML"), bioc_packages_old)
  expect_length(bioc_packages_old, 172)
})
