# EXTRACTING CORE URL ----
test_that("extract_core_url() returns a single string", {
  expect_vector(extract_core_url("https://test.org"),
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
