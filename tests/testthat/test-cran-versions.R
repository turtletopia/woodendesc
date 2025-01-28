skip_if_not_installed("httptest2")
wood_clear_cache()

# SETUP ----
httptest2::with_mock_api({
  versionsort_versions <- wood_cran_versions("versionsort")
})

# TESTS ----
test_versions(versionsort_versions)
test_cache({ wood_cran_versions("versionsort") }, versionsort_versions)
test_param_package(wood_cran_versions(package = "versionsort"))

test_that("versionsort versions contain some of the published version codes", {
  expect_subset(c("1.0.0", "1.1.0"), versionsort_versions)
})

test_that("use cache even if expired, but latest version hasn't changed yet", {
  withr::local_options(list(wood_cache_time = 1))
  Sys.sleep(1.1)

  # Create latest version cache to avoid having a request being made
  httptest2::with_mock_api({
    wood_cran_latest("versionsort")
  })
  expect_cache({ wood_cran_versions("versionsort") }, versionsort_versions)
})

skip_if_offline()
test_that("raises an exception if package not available", {
  expect_error(
    wood_cran_versions("fakepackage"),
    "Can't find package `fakepackage` on CRAN.",
    fixed = TRUE
  )
})
