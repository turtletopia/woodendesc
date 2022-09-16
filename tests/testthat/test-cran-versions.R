skip_if_not_installed("vcr")
wood_clear_cache()

# SETUP ----
vcr::use_cassette("versionsort-versions", {
  versionsort_versions <- wood_cran_versions("versionsort")
})

# TESTS ----
test_param_package(wood_cran_versions)

test_that("returns a vector of strings", {
  expect_vector(versionsort_versions,
                ptype = character())
})

test_that("returned vector of strings is not empty", {
  expect_gt(length(versionsort_versions), 0)
})

test_that("all returned strings are valid version codes", {
  # Using versionsort as I can guarantee validity of its codes
  expect_version_code(versionsort_versions)
})

test_that("versionsort versions contain some of the published version codes", {
  expect_subset(c("1.0.0", "1.1.0"), versionsort_versions)
})

test_that("if possible, reads from cache", {
  expect_cache(wood_cran_versions, versionsort_versions, "versionsort")
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
