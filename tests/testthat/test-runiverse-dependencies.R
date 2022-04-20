skip_if_not_installed("vcr")
wood_clear_cache()

# SETUP ----
vcr::use_cassette("ggplot2-deps-tt", {
  ggplot2_deps <- wood_runiverse_dependencies("ggplot2", "tidyverse")
})

# TESTS ----
test_that("returns a data frame with package, version & type columns", {
  expect_vector(ggplot2_deps,
                ptype = data.frame(
                  package = character(),
                  version = character(),
                  type = character()
                ))
})

test_that("returned 'package' column contains package names", {
  expect_pkg_name(ggplot2_deps[["package"]])
})

test_that("returned 'version' column contains version codes or NA values", {
  expect_true(all(
    is.na(ggplot2_deps[["version"]]) |
      grepl(paste0(">= ", .standard_regexps()$valid_numeric_version),
            ggplot2_deps[["version"]])
  ))
})

test_that("returned 'type' column contains dependency types", {
  expect_subset(
    ggplot2_deps[["type"]],
    c("Depends", "Imports", "Suggests", "LinkingTo", "Enhances")
  )
})

test_that("if possible, reads from cache", {
  expect_cache(wood_runiverse_dependencies, ggplot2_deps,
               package = "ggplot2",
               universe = "tidyverse")
})

test_that("raises an exception if package not available", {
  expect_error(wood_runiverse_dependencies("fakepackage", "turtletopia"))
})
