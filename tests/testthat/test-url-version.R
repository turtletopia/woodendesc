skip_if_not_installed("httptest2")
wood_clear_cache()

# SETUP ----
httptest2::with_mock_api({
  dockerfiler_version <- wood_url_version("dockerfiler", "https://colinfay.me")
})

# TESTS ----
test_version(dockerfiler_version)
test_cache({ wood_url_version("dockerfiler", "https://colinfay.me") }, dockerfiler_version)
test_param_package(wood_url_version(package = "dockerfiler", repository = "https://colinfay.me"))
test_param_url_repo(wood_url_version(package = "dockerfiler", repository = "https://colinfay.me"))

skip_if_offline()
test_that("raises an exception if package not available", {
  expect_error(
    wood_url_version("fakepackage", "https://colinfay.me"),
    "Can't find package `fakepackage` on repository https://colinfay.me.",
    fixed = TRUE
  )
})
