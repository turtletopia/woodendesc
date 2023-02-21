skip_if_not_installed("vcr")
wood_clear_cache()

# SETUP ----
vcr::use_cassette("gglgbtq-latest", {
  gglgbtq_latest <- wood_github_latest("gglgbtq", "turtletopia")
})

# TESTS ----
test_version(gglgbtq_latest)
test_cache(wood_github_latest, gglgbtq_latest, "gglgbtq", "turtletopia")
test_param_package(wood_github_latest, user = "turtletopia")
test_param_gh_user(wood_github_latest, package = "gglgbtq")

vcr::use_cassette("fakepackage-gh-latest", {
  test_that("raises an exception if package not available", {
    expect_error(
      wood_github_latest("fakepackage", "turtletopia"),
      "Can't find repository `turtletopia/fakepackage` on Github.",
      fixed = TRUE
    )
  })
})
