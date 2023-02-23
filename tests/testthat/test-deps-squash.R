# SETUP ----
mixed_pkgs <- c("httr", "digest", "versionsort")
unmixed_deps <- wood_dependencies(mixed_pkgs, repos = "local#all")
mixed_deps <- squash(unmixed_deps)

# TESTS ----
test_squashed(mixed_deps)

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
    unique(squash(filter_dependencies(unmixed_deps, "strong"))[["origin"]]),
    c("httr", "digest")
  )
})
