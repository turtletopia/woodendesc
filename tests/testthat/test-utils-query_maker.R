test_that("constructor creates a query maker", {
  qm <- query_maker("bioc", "version", release = "3.14")

  expect_s3_class(qm, "wood_query_maker")
  expect_type(qm, "list")
  expect_equal(qm[["func"]], wood_bioc_version)
  expect_equal(qm[["args"]], list(release = "3.14"))
})

test_that("adding parameters updates the original object", {
  # Does not exist initially
  qm <- query_maker("runiverse", "packages")
  expect_null(qm[["args"]][["universe"]])
  # Is correctly added
  qm <- add_parameter(qm, "turtletopia", "universe")
  expect_equal(qm[["args"]][["universe"]], "turtletopia")
  # The old parameter is not dropped when adding another
  qm <- add_parameter(qm, 4, "x")
  expect_equal(qm[["args"]], list(universe = "turtletopia", x = 4))
})

test_that("empty parameters are skipped when adding", {
  qm <- query_maker("runiverse", "packages")
  expect_equal(
    add_parameter(qm, character(), "empty"),
    qm
  )
})

test_that("transformations are applied if specified", {
  qm <- query_maker("runiverse", "packages")
  qm <- add_parameter(qm, seq_len(10), "max", value_transform = max)
  expect_equal(qm[["args"]][["max"]], 10)
})
