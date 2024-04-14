skip_if_not_installed("httptest2")
skip_if(over_gh_limit(), "Github rate limit not sufficient")
wood_clear_cache()

# SETUP ----
with_mock_dir("n", {
  gglgbtq_deps <- wood_github_dependencies("gglgbtq", "turtletopia", tag = "v0.1.0")
})

# TESTS ----
test_dependencies(gglgbtq_deps)
test_cache({ wood_github_dependencies("gglgbtq", "turtletopia", tag = "v0.1.0") }, gglgbtq_deps)
test_param_package(wood_github_dependencies, user = "turtletopia")
test_param_gh_user(wood_github_dependencies, package = "gglgbtq")
test_param_tag(wood_github_dependencies, package = "gglgbtq", user = "turtletopia")

with_mock_dir("o", {
  test_that("uses cache from wood_github_versions() if available if not latest commit", {
    wood_clear_cache()
    wood_github_versions("gglgbtq", "turtletopia")
    expect_cache(
      { wood_github_dependencies(package = "gglgbtq", user = "turtletopia", tag = "v0.1.0") },
      gglgbtq_deps
    )
  })
})

with_mock_dir("p", {
  test_that("uses cache from wood_github_latest() if available if latest commit", {
    gglgbtq_deps_latest <- wood_github_dependencies(
      "gglgbtq", "turtletopia", tag = "latest"
    )
    wood_clear_cache()
    wood_github_latest("gglgbtq", "turtletopia")
    expect_cache(
      { wood_github_dependencies(package = "gglgbtq", user = "turtletopia", tag = "latest") },
      gglgbtq_deps_latest
    )
  })
})

skip_if_offline()
test_that("raises an exception if package not available", {
  expect_error(
    wood_github_dependencies("fakepackage", "turtletopia"),
    "Can't find repository `turtletopia/fakepackage` on Github.",
    fixed = TRUE
  )
})

test_that("raises an exception if version not available", {
  expect_error(
    wood_github_dependencies("gglgbtq", "turtletopia", tag = "v0.0.0"),
    "Is `v0.0.0` a valid tag?",
    fixed = TRUE
  )
})
