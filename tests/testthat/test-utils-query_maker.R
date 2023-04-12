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
  qm <- add_parameter(qm, universe = "turtletopia")
  expect_equal(qm[["args"]][["universe"]], "turtletopia")
  # The old parameter is not dropped when adding another
  qm <- add_parameter(qm, x = 4)
  expect_equal(qm[["args"]], list(universe = "turtletopia", x = 4))
})
