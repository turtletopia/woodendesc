skip_if_not_installed("vcr")
wood_clear_cache()

# SETUP ----
vcr::use_cassette("bioc-packages", {
  bioc_packages <- wood_bioc_packages()
}, record = "new_episodes")

# TESTS ----
test_packages(bioc_packages)
test_cache(wood_bioc_packages, bioc_packages)
test_param_bioc_release(wood_bioc_packages)

test_that("there's a Biostrings package in the list", {
  expect_subset("Biostrings", bioc_packages)
})

test_that("works with older releases", {
  vcr::use_cassette("bioc-packages-old", {
    bioc_packages_old <- wood_bioc_packages(release = "1.5")
  }, record = "new_episodes")
  expect_subset(c("affy", "Biostrings", "impute", "RMAGEML"), bioc_packages_old)
  expect_length(bioc_packages_old, 97)
})
