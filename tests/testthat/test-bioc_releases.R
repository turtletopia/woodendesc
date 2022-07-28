skip_if_not_installed("vcr")
wood_clear_cache()

# SETUP ----
vcr::use_cassette("bioc-releases", {
  bioc_releases <- wood_bioc_releases()
}, record = "new_episodes")

# TESTS ----
test_that("returns a vector of strings", {
  expect_vector(bioc_releases,
                ptype = character())
})

test_that("returned vector of strings is not empty", {
  expect_gt(length(bioc_releases), 0)
})

test_that("all returned strings are valid Bioconductor release codes", {
  expect_bioc_release_code(bioc_releases)
})

test_that("bioc releases contain some of the published release codes", {
  expect_subset(c("1.0", "1.9", "2.13", "3.2", "3.14"), bioc_releases)
})

test_that("if possible, reads from cache", {
  expect_cache(wood_bioc_releases, bioc_releases)
})
