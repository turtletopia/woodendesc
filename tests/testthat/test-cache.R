# TEMPDIR ----
test_that("wood_tempdir() always returns an existing directory", {
  # Make sure that there is no cache directory
  unlink(wood_tempdir(), recursive = TRUE)
  # Behavior when cache directory doesn't exist
  expect_true(dir.exists(wood_tempdir()))
  # Running it the second time since the first call should create the directory
  expect_true(dir.exists(wood_tempdir()))
})
