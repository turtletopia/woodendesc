# TEMPDIR ----
test_that("wood_tempdir() always returns an existing directory", {
  # Make sure that there is no cache directory
  unlink(wood_tempdir(), recursive = TRUE)
  # Behavior when cache directory doesn't exist
  expect_true(dir.exists(wood_tempdir()))
  # Running it the second time since the first call should create the directory
  expect_true(dir.exists(wood_tempdir()))
})

# CLEAR CACHE ----
test_that("clearing cache doesn't remove woodendesc temporary directory", {
  wood_clear_cache()
  expect_true(dir.exists(file.path(tempdir(), "woodendesc")))
})

test_that("woodendesc temporary directory is empty after clearing cache", {
  # Generate some cache data
  file.create(file.path(wood_tempdir(), c("file1", "file2")))
  wood_clear_cache()
  expect_equal(length(list.files(wood_tempdir())), 0)
})

# CACHE PATH ----
test_that("cache path is an .rds file", {
  expect_match(cache_path("path"), ".*\\.rds")
})

test_that("cache path separates name components with underscores", {
  expect_match(cache_path("A", "B", "C"), ".*A_B_C\\..*")
})

test_that("cache file name begins with a \"cache_\"", {
  expect_match(cache_path("say", "aloud"), ".*cache_say.*")
})

test_that("cache path is within woodendesc temporary directory", {
  expect_match(cache_path("run", "Forest", "run"), wood_tempdir(), fixed = TRUE)
})

test_that("cache path depends on its arguments only (and tempdir() location)", {
  file.create(cache_path("create", "a", "file"))
  expect_true(file.exists(cache_path("create", "a", "file")))
})
