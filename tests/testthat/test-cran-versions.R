skip_if_not_installed("vcr")
wood_clear_cache()

# SETUP ----
vcr::use_cassette("versionsort-versions", {
  versionsort_versions <- wood_cran_versions("versionsort")
})

# TESTS ----
test_versions(versionsort_versions)
test_cache(wood_cran_versions, versionsort_versions, "versionsort")
test_param_package(wood_cran_versions)

test_that("versionsort versions contain some of the published version codes", {
  expect_subset(c("1.0.0", "1.1.0"), versionsort_versions)
})

test_that("use cache even if expired, but latest version hasn't changed yet", {
  withr::local_options(list(wood_cache_time = 1))
  Sys.sleep(1.1)
  # TODO: simplify once httptest::expect_no_request() works with httr again
  # Create latest version cache to avoid having a request being made
  vcr::use_cassette("versionsort-latest-2", {
    wood_cran_latest("versionsort")
  })
  expect_cache(wood_cran_versions, versionsort_versions, "versionsort")
})

test_that("raises an exception if package not available", {
  expect_error(
    wood_cran_versions("fakepackage"),
    "Can't find package `fakepackage` on CRAN.",
    fixed = TRUE
  )
})
