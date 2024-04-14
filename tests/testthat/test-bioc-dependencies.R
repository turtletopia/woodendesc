skip_if_not_installed("httptest2")
wood_clear_cache()

# SETUP ----
with_mock_dir("a", {
  Biostrings_deps <- wood_bioc_dependencies("Biostrings")
})

# TESTS ----
test_dependencies(Biostrings_deps)
test_cache({ wood_bioc_dependencies("Biostrings") }, Biostrings_deps)
test_param_package(wood_bioc_dependencies)
test_param_bioc_release(wood_bioc_dependencies, package = "Biostrings")

test_that("raises an exception if package not available", {
  expect_error(
    wood_bioc_dependencies("fakepackage"),
    "Can't find package `fakepackage` in Bioconductor release `release`.",
    fixed = TRUE
  )
})

with_mock_dir("b", {
  test_that("correctly retrieves data from older releases", {
    expect_equal(
      wood_bioc_dependencies("Biostrings", release = "1.8"),
      as_wood_deps(data.frame(
        package = c("R", "methods", "hgu95av2probe", "CelegansGenome.ce2"),
        version = c("2.3.0", NA_character_, NA_character_, NA_character_),
        type = c("Depends", "Depends", "Suggests", "Suggests"),
        stringsAsFactors = FALSE
      ))
    )
  })
})
