test_that("after .onLoad all woodendesc options are set", {
  wood_options <- c("wood_cache_time")
  expect_true(all(wood_options %in% names(options())))
})
