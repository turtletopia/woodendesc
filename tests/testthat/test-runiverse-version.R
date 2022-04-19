skip_if_not_installed("vcr")
wood_clear_cache()

# SETUP ----
vcr::use_cassette("versionsort-version-tt", {
  versionsort_version <- wood_runiverse_version("versionsort", "turtletopia")
})

# TESTS ----
test_that("returns a single string", {
  expect_vector(versionsort_version,
                ptype = character(),
                size = 1)
})

test_that("returned string is a version code", {
  # Since I authored versionsort, I can guarantee version codes fitting that regexp
  expect_version_code(versionsort_version)
})

test_that("if possible, reads from cache", {
  expect_cache(wood_runiverse_version, versionsort_version,
               package = "versionsort",
               universe = "turtletopia")
})
