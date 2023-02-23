# SETUP ----
mixed_pkgs <- c("httr", "digest", "versionsort")
unmixed_deps <- wood_dependencies(mixed_pkgs, repos = "local#all")
mixed_deps <- squash(unmixed_deps)

# TESTS ----
# test_dependency() modified slightly
test_that("returns a data frame with origin, package, version & type columns", {
  expect_vector(mixed_deps,
                ptype = as_wood_dep_squashed(data.frame(
                  origin = character(),
                  package = character(),
                  version = character(),
                  type = character(),
                  stringsAsFactors = FALSE
                )))
})

test_that("returned 'origin' column contains package names", {
  pkgs <- mixed_deps[["origin"]]
  expect_pkg_name(pkgs)
})

test_that("returned 'package' column contains package names", {
  pkgs <- mixed_deps[["package"]]
  expect_pkg_name(pkgs)
})

test_that("returned 'version' column contains version codes or NA values", {
  versions <- omit_na(mixed_deps[["version"]])
  if (length(versions) == 0) {
    expect_equal(versions, character())
  } else {
    expect_version_code(versions)
  }
})

test_that("returned 'type' column contains dependency types", {
  expect_dependency_type(mixed_deps[["type"]])
})

# Specific properties
test_that("'origin' column contains only packages that were in dep list", {
  expect_subset(mixed_deps[["origin"]], mixed_pkgs)
})

test_that("'package' column is a concatenation of 'package' columns in dep list", {
  expect_equal(
    mixed_deps[["package"]],
    unname(do.call(c, lapply(unmixed_deps, `[[`, "package")))
  )
})

test_that("packages with no deps are omitted", {
  expect_setequal(
    unique(squash(filter_dependencies(unmixed_deps, "strong"))[["package"]]),
    c("httr", "digest")
  )
})
