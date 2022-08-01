skip_if_not_installed("vcr")
wood_clear_cache()

# SETUP ----
# Re-record on older R versions since it queries for PACKAGES without .gz
vcr::use_cassette("Biostrings-deps", {
  Biostrings_deps <- wood_bioc_dependencies("Biostrings")
}, record = "new_episodes")

# TESTS ----
test_dependencies(Biostrings_deps, wood_bioc_dependencies, "Biostrings")

test_that("raises an exception if package not available", {
  expect_error(wood_bioc_dependencies("fakepackage"))
})

vcr::use_cassette("Biostrings-deps-old", {
  test_that("correctly retrieves data from older releases", {
    Biostrings_deps_old <- wood_bioc_dependencies("Biostrings", release = "1.5")

    expect_equal(
      Biostrings_deps_old,
      data.frame(
        package = "R",
        version = "1.8.0",
        type = "Depends",
        stringsAsFactors = FALSE
      )
    )
  })
}, record = "new_episodes")