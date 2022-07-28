skip_if_not_installed("vcr")
wood_clear_cache()

# SETUP ----
vcr::use_cassette("deepdep-deps", {
  deepdep_deps <- wood_cran_dependencies("deepdep", version = "0.2.0")
})

# TESTS ----
test_dependencies(
  deepdep_deps, wood_cran_dependencies, "deepdep", version = "0.2.0"
)

test_that("uses cache from wood_cran_versions() if available", {
  wood_clear_cache()
  wood_cran_versions("deepdep")
  expect_cache(wood_cran_dependencies, deepdep_deps,
               package = "deepdep",
               version = "0.2.0")
})

vcr::use_cassette("deepdep-deps-latest", {
  test_that("version = 'latest' is an alias to latest package version", {
    expect_equal(
      wood_cran_dependencies("deepdep", "latest"),
      wood_cran_dependencies("deepdep", wood_cran_latest("deepdep"))
    )
  })
})

vcr::use_cassette("fakepackage-cran-deps", {
  test_that("raises an exception if package not available", {
    expect_error(wood_cran_dependencies("fakepackage"))
  })
})
