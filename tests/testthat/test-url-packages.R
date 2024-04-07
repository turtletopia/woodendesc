skip_if_not_installed("httptest2")
wood_clear_cache()

# SETUP ----
with_mock_dir("y", {
  cynkra_packages <- wood_url_packages("https://cynkra.r-universe.dev")
})

# TESTS ----
test_packages(cynkra_packages)
test_cache(wood_url_packages, cynkra_packages, "https://cynkra.r-universe.dev")
test_param_url_repo(wood_url_packages)

test_that("Cynkra repository has cynkrathis package", {
  expect_subset("cynkrathis", cynkra_packages)
})

with_mock_dir("x", {
  test_that("url_packages() uses PACKAGES if PACKAGES.gz is not available", {
    expect_no_error(wood_url_packages("https://colinfay.me"))
  })
})

test_that("trailing slash url and without one share the same cache", {
  expect_cache(wood_url_packages, cynkra_packages, "https://cynkra.r-universe.dev/")
})
