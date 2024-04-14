skip_if_not_installed("httptest2")
wood_clear_cache()

# SETUP ----
with_mock_dir("l0", {
  rock_deps <- wood_gitlab_dependencies("rock", "r-packages", tag = "0.6.0")
})

# TESTS ----
test_dependencies(rock_deps)
test_cache({ wood_gitlab_dependencies("rock", "r-packages", tag = "0.6.0") }, rock_deps)
test_param_package(wood_gitlab_dependencies(package = "rock", user = "r-packages"))
test_param_gh_user(wood_gitlab_dependencies(package = "rock", user = "r-packages"))
test_param_tag(wood_gitlab_dependencies(package = "rock", user = "r-packages"))

# with_mock_dir("l1", {
#   test_that("uses cache from wood_gitlab_versions() if available if not latest commit", {
#     wood_clear_cache()
#     wood_gitlab_versions("rock", "r-packages")
#     expect_cache(wood_gitlab_dependencies, rock_deps,
#                  package = "rock",
#                  user = "r-packages",
#                  tag = "0.6.0")
#   })
# })

with_mock_dir("l2", {
  test_that("uses cache from wood_gitlab_latest() if available if latest commit", {
    rock_deps_latest <- wood_gitlab_dependencies(
      "rock", "r-packages", tag = "latest"
    )
    wood_clear_cache()
    wood_gitlab_latest("rock", "r-packages")
    expect_cache(
      { wood_gitlab_dependencies(package = "rock", user = "r-packages", tag = "latest") },
      rock_deps_latest
    )
  })
})

skip_if_offline()
test_that("raises an exception if package not available", {
  expect_error(
    wood_gitlab_dependencies("fakepackage", "r-packages"),
    "Can't find repository `r-packages/fakepackage` on Gitlab.",
    fixed = TRUE
  )
})

test_that("raises an exception if version not available", {
  expect_error(
    wood_gitlab_dependencies("rock", "r-packages", tag = "v0.0.0"),
    "Is `v0.0.0` a valid tag?",
    fixed = TRUE
  )
})
