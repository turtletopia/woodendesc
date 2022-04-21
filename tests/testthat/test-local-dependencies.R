# SETUP ----
woodendesc_deps <- wood_local_dependencies("woodendesc")

# TESTS ----
test_that("returns a data frame with package, version & type columns", {
  expect_vector(woodendesc_deps,
                ptype = data.frame(
                  package = character(),
                  version = character(),
                  type = character(),
                  stringsAsFactors = FALSE
                ))
})

test_that("returned 'package' column contains package names", {
  expect_pkg_name(woodendesc_deps[["package"]])
})

test_that("returned 'version' column contains version codes or NA values", {
  versions <- omit_na(woodendesc_deps[["version"]])
  if (length(versions) == 0) {
    expect_equal(versions, character())
  } else {
    expect_version_code(versions)
  }
})

test_that("returned 'type' column contains dependency types", {
  expect_dependency_type(woodendesc_deps[["type"]])
})

test_that("raises an exception if package not available", {
  expect_error(wood_local_dependencies("notapackage"))
})
