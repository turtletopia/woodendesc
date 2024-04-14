skip_if_not_installed("httptest2")
wood_clear_cache()

# SETUP ----
with_mock_dir("l4", {
  r_packages_packages <- wood_gitlab_packages("r-packages")
})

# TESTS ----
test_packages(r_packages_packages)
test_cache({ wood_gitlab_packages(user = "r-packages") }, r_packages_packages)
test_param_gh_user(wood_gitlab_packages)
test_param_include_forks(wood_gitlab_packages, user = "r-packages")

test_that("several packages make the list", {
  expect_subset(c("rock", "limonaid", "preregr"), r_packages_packages)
})

test_that("non-packages are omitted", {
  expect_no_match(r_packages_packages, "^eta$")
})

skip_if_offline()
test_that("if user doesn't exist, an exception is raised", {
  expect_error(
    wood_gitlab_packages("TheUserThatDoesNotExist"),
    "Can't find user or group `TheUserThatDoesNotExist` on GitLab.",
    fixed = TRUE
  )
})
