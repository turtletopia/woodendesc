test_cache <- function(tested_function, expected_value, ...) {
  test_that("if possible, reads from cache", {
    expect_cache(tested_function, expected_value, ...)
  })
}

test_packages <- function(packages) {
  test_that("returns a vector of strings", {
    expect_vector(packages,
                  ptype = character())
  })

  test_that("returned vector of strings is not empty", {
    expect_gt(length(packages), 0)
  })

  test_that("all returned strings are valid package names", {
    expect_pkg_name(packages)
  })
}

test_version <- function(version) {
  test_that("returns a single string", {
    expect_vector(version,
                  ptype = character(),
                  size = 1)
  })

  test_that("returned string is a version code", {
    expect_version_code(version)
  })
}

test_versions <- function(versions) {
  test_that("returns a vector of strings", {
    expect_vector(versions,
                  ptype = character())
  })

  test_that("returned vector of strings is not empty", {
    expect_gt(length(versions), 0)
  })

  test_that("all returned strings are valid version codes", {
    expect_version_code(versions)
  })
}

test_tags <- function(tags) {
  test_that("returns a vector of strings", {
    expect_vector(tags,
                  ptype = character())
  })

  test_that("returned vector of strings is not empty", {
    expect_gt(length(tags), 0)
  })
}

test_dependencies <- function(deps) {
  test_that("returns a data frame with package, version & type columns", {
    expect_vector(deps,
                  ptype = as_wood_deps(data.frame(
                    package = character(),
                    version = character(),
                    type = character(),
                    stringsAsFactors = FALSE
                  )))
  })

  test_that("returned 'package' column contains package names", {
    pkgs <- deps[["package"]]
    if (length(pkgs) == 0) {
      expect_equal(pkgs, character())
    } else {
      expect_pkg_name(pkgs)
    }
  })

  test_that("returned 'version' column contains version codes or NA values", {
    versions <- omit_na(deps[["version"]])
    if (length(versions) == 0) {
      expect_equal(versions, character())
    } else {
      expect_version_code(versions)
    }
  })

  test_that("returned 'type' column contains dependency types", {
    expect_dependency_type(deps[["type"]])
  })
}

test_squashed <- function(deps) {
  test_that("returns a data frame with origin, package, version & type columns", {
    expect_vector(deps,
                  ptype = as_wood_dep_squashed(data.frame(
                    origin = character(),
                    package = character(),
                    version = character(),
                    type = character(),
                    stringsAsFactors = FALSE
                  )))
  })

  test_that("returned 'origin' column contains package names", {
    pkgs <- deps[["origin"]]
    if (length(pkgs) == 0) {
      expect_equal(pkgs, character())
    } else {
      expect_pkg_name(pkgs)
    }
  })

  test_that("returned 'package' column contains package names", {
    pkgs <- deps[["package"]]
    if (length(pkgs) == 0) {
      expect_equal(pkgs, character())
    } else {
      expect_pkg_name(pkgs)
    }
  })

  test_that("returned 'version' column contains version codes or NA values", {
    versions <- omit_na(deps[["version"]])
    if (length(versions) == 0) {
      expect_equal(versions, character())
    } else {
      expect_version_code(versions)
    }
  })

  test_that("returned 'type' column contains dependency types", {
    expect_dependency_type(deps[["type"]])
  })
}

test_list_of <- function(object, names, test) {
  test_that("returns an object with list structure", {
    expect_type(object, "list")
  })

  test_that("each element is named after parameter value", {
    expect_named(object, names)
  })

  lapply(object, test)
}
