skip_if_not_installed("httptest2")
skip_if(over_gh_limit(), "Github rate limit not sufficient")
wood_clear_cache()

# SETUP ----
httptest2::with_mock_api({
  gglgbtq_versions <- wood_github_versions("gglgbtq", "turtletopia")
})

# TESTS ----
test_versions(gglgbtq_versions)
test_cache({ wood_github_versions("gglgbtq", "turtletopia") }, gglgbtq_versions)
test_param_package(wood_github_versions(package = "gglgbtq", user = "turtletopia"))
test_param_gh_user(wood_github_versions(package = "gglgbtq", user = "turtletopia"))

test_that("gglgbtq versions contain some of the tagged version codes", {
  expect_subset(c("0.1.0", "0.1.1"), gglgbtq_versions)
})

skip_if_offline()
test_that("raises an exception if package not available", {
  expect_error(
    wood_github_versions("fakepackage", "turtletopia"),
    "Can't find repository `turtletopia/fakepackage` on Github.",
    fixed = TRUE
  )
})
