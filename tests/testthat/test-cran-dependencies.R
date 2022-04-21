skip_if_not_installed("vcr")
wood_clear_cache()

# SETUP ----
vcr::use_cassette("deepdep-deps", {
  deepdep_deps <- wood_cran_dependencies("deepdep", version = "0.2.0")
})

# TESTS ----
test_that("returns a data frame with package, version & type columns", {
  expect_vector(deepdep_deps,
                ptype = data.frame(
                  package = character(),
                  version = character(),
                  type = character(),
                  stringsAsFactors = FALSE
                ))
})

test_that("returned 'package' column contains package names", {
  expect_pkg_name(deepdep_deps[["package"]])
})

test_that("returned 'version' column contains version codes or NA values", {
  versions <- omit_na(deepdep_deps[["version"]])
  if (length(versions) == 0) {
    expect_equal(versions, character())
  } else {
    expect_version_code(versions)
  }
})

test_that("returned 'type' column contains dependency types", {
  expect_dependency_type(deepdep_deps[["type"]])
})

test_that("if possible, reads from cache", {
  expect_cache(wood_cran_dependencies, deepdep_deps,
               package = "deepdep",
               version = "0.2.0")
})

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

test_that("raises an exception if package not available", {
  expect_error(wood_cran_dependencies("fakepackage"))
})
