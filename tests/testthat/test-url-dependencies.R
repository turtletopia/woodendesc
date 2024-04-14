skip_if_not_installed("httptest2")
wood_clear_cache()

# SETUP ----
with_mock_dir("x", {
  dockerfiler_deps <- wood_url_dependencies("dockerfiler", "https://colinfay.me")
})

# TESTS ----
test_dependencies(dockerfiler_deps)
test_cache({ wood_url_dependencies("dockerfiler", "https://colinfay.me") }, dockerfiler_deps)
test_param_package(wood_url_dependencies, repository = "https://colinfay.me")
test_param_url_repo(wood_url_dependencies, package = "dockerfiler")

skip_if_offline()
test_that("raises an exception if package not available", {
  expect_error(
    wood_url_dependencies("fakepackage", "https://colinfay.me"),
    "Can't find package `fakepackage` on repository https://colinfay.me.",
    fixed = TRUE
  )
})
