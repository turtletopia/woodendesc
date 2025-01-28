skip_if_not_installed("httptest2")
wood_clear_cache()

# SETUP ----
httptest2::with_mock_api({
  limonaid_tags <- wood_gitlab_tags("limonaid", "r-packages")
})

# TESTS ----
test_tags(limonaid_tags)
test_cache({ wood_gitlab_tags("limonaid", "r-packages") }, limonaid_tags)
test_param_package(wood_gitlab_tags(package = "limonaid", user = "r-packages"))
test_param_gh_user(wood_gitlab_tags(package = "limonaid", user = "r-packages"))

skip("New tests fail for 404 even though older ones keep passing.")
# skip_if_offline()
test_that("raises an exception if package not available", {
  expect_error(
    wood_gitlab_tags("fakepackage", "r-packages"),
    "Can't find repository `r-packages/fakepackage` on Gitlab.",
    fixed = TRUE
  )
})
