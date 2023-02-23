# SETUP ----
woodendesc_deps <- wood_local_dependencies("woodendesc")
mixed_deps <- wood_dependencies(
  c("httr", "digest", "versionsort"),
  repos = "local#all"
)
empty_deps <- as_wood_deps(data.frame(
  package = character(),
  version = character(),
  type = character(),
  stringsAsFactors = FALSE
))

# TESTS ----
test_dependencies(filter_dependencies(woodendesc_deps, "strong"))
test_param_which_deps(filter_dependencies, object = empty_deps)
lapply(filter_dependencies(mixed_deps, "strong"), function(deps) {
  test_dependencies(deps)
})
test_squashed(filter_dependencies(squash(mixed_deps), "strong"))

test_that("if no dependencies matching a filter, an empty `wood_deps` object is returned", {
  expect_equal(
    filter_dependencies(woodendesc_deps, "LinkingTo"),
    empty_deps
  )
})

test_that("'all' preserves all dependencies", {
  expect_equal(
    filter_dependencies(mixed_deps, "all"),
    mixed_deps
  )
})

test_that("'most' removes only 'Enhances'", {
  expect_no_match(
    filter_dependencies(woodendesc_deps, "most")[["type"]],
    "Enhances",
    fixed = TRUE
  )
})

test_that("'strong' removes weak dependencies", {
  expect_subset(
    filter_dependencies(woodendesc_deps, "strong")[["type"]],
    c("Depends", "Imports", "LinkingTo")
  )
})

test_that("NULL remains unchanged", {
  expect_null(filter_dependencies(NULL, "strong"))
})
