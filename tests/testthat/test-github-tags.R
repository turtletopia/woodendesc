skip_if_not_installed("httptest2")
skip_if(over_gh_limit(), "Github rate limit not sufficient")
wood_clear_cache()

# SETUP ----
with_mock_dir("s", {
  gglgbtq_tags <- wood_github_tags("gglgbtq", "turtletopia")
})

# TESTS ----
test_tags(gglgbtq_tags)
test_cache({ wood_github_tags("gglgbtq", "turtletopia") }, gglgbtq_tags)
test_param_package(wood_github_tags(package = "gglgbtq", user = "turtletopia"))
test_param_gh_user(wood_github_tags(package = "gglgbtq", user = "turtletopia"))

skip_if_offline()
test_that("raises an exception if package not available", {
  expect_error(
    wood_github_latest("fakepackage", "turtletopia"),
    "Can't find repository `turtletopia/fakepackage` on Github.",
    fixed = TRUE
  )
})
