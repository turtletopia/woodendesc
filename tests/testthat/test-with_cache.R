wood_clear_cache()

test_that("with_cache() returns a value when no outside variables", {
  expect_equal(with_cache({ 5 }), 5)
})

test_that("with_cache() accepts cache path", {
  expect_equal(
    with_cache({ "used" }, "temporary", "path"),
    "used"
  )
  expect_subset(
    cache_path("temporary", "path"),
    list.files(wood_tempdir(), full.names = TRUE)
  )
})

test_that("with_cache() returns cached value if called again with the same path", {
  expect_equal(
    with_cache({ "unused" }, "temporary", "path"),
    "used"
  )
})

test_that("with_cache() works with outside variables", {
  local_var <- 10

  expect_equal(
    with_cache({
      local_var^2
    }, "some", "other", "cache"),
    100
  )
})
