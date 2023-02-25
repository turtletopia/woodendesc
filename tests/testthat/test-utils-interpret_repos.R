# CRAN ----
test_that("'cran' is a valid repo name", {
  expect_equal(
    interpret_repos("cran", "version")[[1]],
    query_maker("cran", "version")
  )
})

# core ----
test_that("'core' is a valid repo name", {
  expect_equal(
    interpret_repos("core", "version")[[1]],
    query_maker("core", "version")
  )
})

# Bioconductor ----
test_that("'bioc' is a valid repo name", {
  expect_equal(
    interpret_repos("bioc", "version")[[1]],
    query_maker("bioc", "version")
  )
})

test_that("'bioc' accepts a release after @", {
  expect_equal(
    interpret_repos("bioc@3.14", "version")[[1]],
    query_maker("bioc", "version", release = "3.14")
  )
  expect_equal(
    interpret_repos("bioc@devel", "version")[[1]],
    query_maker("bioc", "version", release = "devel")
  )
})

# local ----
test_that("'local' is a valid repo name", {
  expect_equal(
    interpret_repos("local", "version")[[1]],
    query_maker("local", "version")
  )
})

test_that("'local' accepts an index after #", {
  expect_equal(
    interpret_repos("local#1", "version")[[1]],
    query_maker("local", "version", paths = .libPaths()[1])
  )
  expect_equal(
    interpret_repos("local#all", "version")[[1]],
    query_maker("local", "version", paths = "all")
  )
})

# GitHub ----
test_that("'github' is a valid repo name", {
  expect_equal(
    interpret_repos("github", "version")[[1]],
    query_maker("github", "version")
  )
})

test_that("'github' accepts a username after /", {
  expect_equal(
    interpret_repos("github/ErdaradunGaztea", "version")[[1]],
    query_maker("github", "version", user = "ErdaradunGaztea")
  )
})

# R-universe ----
test_that("'runiverse' is a valid repo name", {
  expect_equal(
    interpret_repos("runiverse", "version")[[1]],
    query_maker("runiverse", "version")
  )
})

test_that("'runiverse' accepts a universe after @", {
  expect_equal(
    interpret_repos("runiverse@turtletopia", "version")[[1]],
    query_maker("runiverse", "version", universe = "turtletopia")
  )
})

# URL ----
test_that("everything else is interpreted as a URL", {
  url <- "http://www.omegahat.net/R"
  expect_equal(
    interpret_repos(url, "version")[[1]],
    query_maker("url", "version", repository = url)
  )

  url <- "not-a-url"
  expect_equal(
    interpret_repos(url, "version")[[1]],
    query_maker("url", "version", repository = url)
  )
})

# multiple ----
test_that("mutliple repos may be specified simultaneously", {
  expect_equal(
    interpret_repos(c("cran", "bioc@devel", "local#all", "bioc@3.5"), "version"),
    list(
      query_maker("cran", "version"),
      query_maker("bioc", "version", release = "devel"),
      query_maker("local", "version", paths = "all"),
      query_maker("bioc", "version", release = "3.5")
    )
  )
})
