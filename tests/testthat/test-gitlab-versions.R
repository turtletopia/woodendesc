skip_if_not_installed("httptest2")
wood_clear_cache()

# SETUP ----
httptest2::with_mock_api({
  limonaid_versions <- wood_gitlab_versions("limonaid", "r-packages")
})

# TESTS ----
test_versions(limonaid_versions)
test_cache({ wood_gitlab_versions("limonaid", "r-packages") }, limonaid_versions)
test_param_package(wood_gitlab_versions(package = "limonaid", user = "r-packages"))
test_param_gh_user(wood_gitlab_versions(package = "limonaid", user = "r-packages"))

test_that("limonaid versions contain some of the tagged version codes", {
  expect_subset(c("0.1.1", "0.1.3"), limonaid_versions)
})

skip("New tests fail for 404 even though older ones keep passing.")
# skip_if_offline()
test_that("raises an exception if package not available", {
  expect_error(
    wood_gitlab_versions("fakepackage", "r-packages"),
    "Can't find repository `r-packages/fakepackage` on Gitlab.",
    fixed = TRUE
  )
})
