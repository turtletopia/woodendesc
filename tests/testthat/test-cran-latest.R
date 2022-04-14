skip_if_not_installed("vcr")

# SETUP ----
vcr::use_cassette("versionsort-latest", {
  versionsort_latest <- wood_cran_latest("versionsort")
})

# TESTS ----
test_that("returns a single string", {
  expect_vector(versionsort_latest,
                ptype = character(),
                size = 1)
})

test_that("returned string is a version code", {
  # Since I authored versionsort, I can guarantee version codes fitting that regexp
  expect_version_code(versionsort_latest)
})

test_that("if possible, reads from cache", {
  expect_cache(wood_cran_latest, versionsort_latest, "versionsort")
})
