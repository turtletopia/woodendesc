skip_if_not_installed("vcr")
wood_clear_cache()

# SETUP ----
# Re-record on older R versions since it queries for PACKAGES without .gz
vcr::use_cassette("RDG-deps", {
  RGD_deps <- wood_url_dependencies(
    "RGraphicsDevice", "http://www.omegahat.net/R"
  )
}, record = "new_episodes")

# TESTS ----
test_that("returns a data frame with package, version & type columns", {
  expect_vector(RGD_deps,
                ptype = data.frame(
                  package = character(),
                  version = character(),
                  type = character(),
                  stringsAsFactors = FALSE
                ))
})

test_that("returned 'package' column contains package names", {
  expect_pkg_name(RGD_deps[["package"]])
})

test_that("returned 'version' column contains version codes or NA values", {
  versions <- omit_na(RGD_deps[["version"]])
  if (length(versions) == 0) {
    expect_equal(versions, character())
  } else {
    expect_version_code(versions)
  }
})

test_that("returned 'type' column contains dependency types", {
  expect_dependency_type(RGD_deps[["type"]])
})

test_that("if possible, reads from cache", {
  expect_cache(wood_url_dependencies, RGD_deps,
               package = "RGraphicsDevice",
               repository = "http://www.omegahat.net/R")
})

test_that("raises an exception if package not available", {
  expect_error(wood_runiverse_dependencies(
    "notavailable", "http://www.omegahat.net/R"
  ))
})
