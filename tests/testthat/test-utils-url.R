# CACHE ----
vcr::use_cassette("bioc-releases-cache", {
  wood_bioc_releases()
})

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

# BIOC RELEASE URL ----
test_that("bioc_release_url() returns a single string", {
  expect_vector(bioc_release_url("3.12"),
                ptype = character(),
                size = 1)
  expect_vector(bioc_release_url("2.1", "src", "contrib"),
                ptype = character(),
                size = 1)
})

test_that("bioc_release_url() separates API with slashes", {
  expect_match(
    bioc_release_url("2.1", "src", "contrib"),
    "packages/2.1/bioc/src/contrib",
    fixed = TRUE
  )
})

test_that("bioc_release_url() uses different path for older releases", {
  expect_match(
    bioc_release_url("1.8", "src", "contrib"),
    "packages/1.8/bioc/src/contrib",
    fixed = TRUE
  )
  expect_match(
    bioc_release_url("1.7", "src", "contrib"),
    "packages/bioc/1.7/src/contrib",
    fixed = TRUE
  )
})

test_that("bioc_release_url() doesn't support releases older than 1.5", {
  expect_error(
    bioc_release_url("1.4", "src", "contrib"),
    "`release` must be at least 1.5.",
    fixed = TRUE
  )
})

test_that("bioc_release_url() throws exception for non-existent releases", {
  expect_error(
    bioc_release_url("3.6.1"),
    "Bioconductor release 3.6.1 does not exist.",
    fixed = TRUE
  )
  expect_error(
    bioc_release_url("1.15"),
    "Bioconductor release 1.15 does not exist.",
    fixed = TRUE
  )
})

test_that("bioc_release_url() allows keywords for release", {
  expect_match(
    bioc_release_url("release", "src", "contrib"),
    "packages/release/bioc/src/contrib",
    fixed = TRUE
  )
  expect_match(
    bioc_release_url("devel", "src", "contrib"),
    "packages/devel/bioc/src/contrib",
    fixed = TRUE
  )
})

# CRAN URL ----
test_that("crandb_url() returns a single string", {
  expect_vector(crandb_url("-"),
                ptype = character(),
                size = 1)
  expect_vector(crandb_url("-", "allall"),
                ptype = character(),
                size = 1)
  expect_vector(crandb_url("-", "allall", params = list(start_key = "deepdep", limit = 1)),
                ptype = character(),
                size = 1)
})

test_that("crandb_url() separates API with slashes", {
  expect_match(
    crandb_url("-", "allall"),
    "/-/allall",
    fixed = TRUE
  )
})

# EXTRACTING CORE URL ----
test_that("extract_core_url() returns a single string", {
  expect_vector(extract_core_url(runiverse_url("ropensci")),
                ptype = character(),
                size = 1)
  expect_vector(extract_core_url(crandb_url("-", "desc", params = list(limit = 1))),
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

# TRAILING SLASH ----
test_that("remove_trailing_slash() returns a single string", {
  expect_vector(remove_trailing_slash(runiverse_url("ropensci")),
                ptype = character(),
                size = 1)
  expect_vector(remove_trailing_slash("https://cynkra.r-universe.dev/"),
                ptype = character(),
                size = 1)
})

test_that("a trailing slash is removed if present", {
  test_url <- remove_trailing_slash("https://test.org/")
  expect_no_match(test_url, "/$")
  expect_match(test_url, "https://test.org", fixed = TRUE)
})

test_that("if no trailing slash, url returned is the same as input", {
  test_url <- "https://test.org"
  expect_equal(remove_trailing_slash(test_url), test_url)
})

test_that("add_trailing_slash() returns a single string", {
  expect_vector(add_trailing_slash(runiverse_url("ropensci")),
                ptype = character(),
                size = 1)
  expect_vector(add_trailing_slash("https://cynkra.r-universe.dev/"),
                ptype = character(),
                size = 1)
})

test_that("a trailing slash is added if missing", {
  test_url <- add_trailing_slash("https://test.org")
  expect_match(test_url, "https://test.org/", fixed = TRUE)
})

test_that("if trailing slash is present, url returned is the same as input", {
  test_url <- "https://test.org/"
  expect_equal(add_trailing_slash(test_url), test_url)
})
