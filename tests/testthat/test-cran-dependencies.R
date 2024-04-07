skip_if_not_installed("httptest2")
wood_clear_cache()

# SETUP ----
with_mock_dir("h", {
  deepdep_deps <- wood_cran_dependencies("deepdep", version = "0.2.0")
})

# TESTS ----
test_dependencies(deepdep_deps)
test_cache(wood_cran_dependencies, deepdep_deps, "deepdep", version = "0.2.0")
test_param_package(wood_cran_dependencies, version = "0.2.0")
test_param_version(wood_cran_dependencies, package = "deepdep")

test_that("uses cache from wood_cran_versions() if available", {
  wood_clear_cache()
  wood_cran_versions("deepdep")
  expect_cache(wood_cran_dependencies, deepdep_deps,
               package = "deepdep",
               version = "0.2.0")
})

with_mock_dir("i", {
  test_that("version = 'latest' is an alias to latest package version", {
    expect_equal(
      wood_cran_dependencies("deepdep", "latest"),
      wood_cran_dependencies("deepdep", wood_cran_latest("deepdep"))
    )
  })
})

skip_if_offline()
test_that("raises an exception if package not available", {
  expect_error(
    wood_cran_dependencies("fakepackage"),
    "Can't find package `fakepackage` on CRAN.",
    fixed = TRUE
  )
})

test_that("raises an exception if version not available", {
  expect_error(
    wood_cran_dependencies("fakepackage", version = "0.1.0"),
    "Can't find package `fakepackage` or version `0.1.0` on CRAN.",
    fixed = TRUE
  )
})
