skip_if_not_installed("vcr")
wood_clear_cache()

# SETUP ----
vcr::use_cassette("versionsort-latest", {
  versionsort_latest <- wood_cran_latest("versionsort")
})

# TESTS ----
test_version(versionsort_latest)
test_cache(wood_cran_latest, versionsort_latest, "versionsort")
test_param_package(wood_cran_latest)

vcr::use_cassette("fakepackage-cran-latest", {
  test_that("raises an exception if package not available", {
    expect_error(
      wood_cran_latest("fakepackage"),
      "Can't find package `fakepackage` on CRAN.",
      fixed = TRUE
    )
  })
})
