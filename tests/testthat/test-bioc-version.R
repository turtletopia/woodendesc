skip_if_not_installed("httptest2")
wood_clear_cache()

# SETUP ----
httptest2::with_mock_api({
  a4_version <- wood_bioc_version("a4")
})

# TESTS ----
test_version(a4_version)
test_cache({ wood_bioc_version("a4") }, a4_version)
test_param_package(wood_bioc_version(package = "a4"))
test_param_bioc_release(wood_bioc_version(package = "a4"))

httptest2::with_mock_api({
  test_that("correctly retrieves data from older releases", {
    expect_equal(
      wood_bioc_version("affy", release = "1.8"),
      "1.10.0"
    )
  })
})

skip_if_offline()
test_that("raises an exception if package not available", {
  expect_error(
    wood_bioc_version("fakepackage", release = "3.14"),
    "Can't find package `fakepackage` in Bioconductor release `3.14`.",
    fixed = TRUE
  )
})
