skip_if_not_installed("vcr")
wood_clear_cache()

# SETUP ----
vcr::use_cassette("gglgbtq-versions", {
  gglgbtq_versions <- wood_github_versions("gglgbtq", "turtletopia")
})

# TESTS ----
test_versions(gglgbtq_versions)
test_cache(wood_github_versions, gglgbtq_versions, "gglgbtq", "turtletopia")
test_param_package(wood_github_versions, user = "turtletopia")
test_param_gh_user(wood_github_versions, package = "gglgbtq")

test_that("gglgbtq versions contain some of the tagged version codes", {
  expect_subset(c("0.1.0", "0.1.1"), gglgbtq_versions)
})

vcr::use_cassette("fakepackage-gh-versions", {
  test_that("raises an exception if package not available", {
    expect_error(
      wood_github_versions("fakepackage", "turtletopia"),
      "Can't find repository `turtletopia/fakepackage` on Github.",
      fixed = TRUE
    )
  })
})
