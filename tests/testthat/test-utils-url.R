# R-UNIVERSE URL ----
test_that("runiverse_url() returns a single string", {
  expect_vector(runiverse_url("ropensci"),
                ptype = character(),
                size = 1)
  expect_vector(runiverse_url("tidyverse", "packages", "ggplot2"),
                ptype = character(),
                size = 1)
})

test_that("runiverse_url() separates API with slashes", {
  expect_match(
    runiverse_url("tidyverse", "packages", "ggplot2"),
    "/packages/ggplot2",
    fixed = TRUE
  )
})

# BIOC URL ----
test_that("bioc_url() returns a single string", {
  expect_vector(bioc_url("install"),
                ptype = character(),
                size = 1)
  expect_vector(bioc_url("packages", "release", "bioc", "VIEWS"),
                ptype = character(),
                size = 1)
})

test_that("bioc_url() separates API with slashes", {
  expect_match(
    bioc_url("packages", "release", "bioc", "VIEWS"),
    "/packages/release/bioc/VIEWS",
    fixed = TRUE
  )
})

# CRAN URL ----
test_that("cran_url() returns a single string", {
  expect_vector(cran_url("-"),
                ptype = character(),
                size = 1)
  expect_vector(cran_url("-", "allall"),
                ptype = character(),
                size = 1)
  expect_vector(cran_url("-", "allall", params = list(start_key = "deepdep", limit = 1)),
                ptype = character(),
                size = 1)
})

test_that("cran_url() separates API with slashes", {
  expect_match(
    cran_url("-", "allall"),
    "/-/allall",
    fixed = TRUE
  )
})

# EXTRACTING CORE URL ----
test_that("extract_core_url() returns a single string", {
  expect_vector(extract_core_url(runiverse_url("ropensci")),
                ptype = character(),
                size = 1)
  expect_vector(extract_core_url(cran_url("-", "desc", params = list(limit = 1))),
                ptype = character(),
                size = 1)
})

test_that("core url has everything removed starting with a quotation mark", {
  test_url <- extract_core_url("https://test.org?limit=10&start=11")
  expect_no_match(test_url, "\\?.*")
  expect_match(test_url, "https://test.org", fixed = TRUE)
})

test_that("if no parameters given, core url is the same as input", {
  test_url <- "https://test.org"
  expect_equal(extract_core_url(test_url), test_url)
})
