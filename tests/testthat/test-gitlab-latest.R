skip_if_not_installed("httptest2")
wood_clear_cache()

# SETUP ----
with_mock_dir("l3", {
  rock_latest <- wood_gitlab_latest("rock", "r-packages")
})

# TESTS ----
test_version(rock_latest)
test_cache({ wood_gitlab_latest("rock", "r-packages") }, rock_latest)
test_param_package(wood_gitlab_latest(package = "rock", user = "r-packages"))
test_param_gh_user(wood_gitlab_latest(package = "rock", user = "r-packages"))

skip_if_offline()
test_that("raises an exception if package not available", {
  expect_error(
    wood_gitlab_latest("fakepackage", "r-packages"),
    "Can't find repository `r-packages/fakepackage` on Gitlab.",
    fixed = TRUE
  )
})
