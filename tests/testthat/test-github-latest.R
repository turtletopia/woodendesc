skip_if_not_installed("httptest2")
skip_if(over_gh_limit(), "Github rate limit not sufficient")
wood_clear_cache()

# SETUP ----
with_mock_dir("q", {
  gglgbtq_latest <- wood_github_latest("gglgbtq", "turtletopia")
})

# TESTS ----
test_version(gglgbtq_latest)
test_cache({ wood_github_latest("gglgbtq", "turtletopia") }, gglgbtq_latest)
test_param_package(wood_github_latest, user = "turtletopia")
test_param_gh_user(wood_github_latest, package = "gglgbtq")

skip_if_offline()
test_that("raises an exception if package not available", {
  expect_error(
    wood_github_latest("fakepackage", "turtletopia"),
    "Can't find repository `turtletopia/fakepackage` on Github.",
    fixed = TRUE
  )
})
