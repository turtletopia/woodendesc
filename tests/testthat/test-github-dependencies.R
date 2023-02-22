skip_if_not_installed("vcr")
wood_clear_cache()

# SETUP ----
vcr::use_cassette("gglgbtq-deps", {
  gglgbtq_deps <- wood_github_dependencies("gglgbtq", "turtletopia", tag = "v0.1.0")
})

# TESTS ----
test_dependencies(gglgbtq_deps)
test_cache(
  wood_github_dependencies, gglgbtq_deps, "gglgbtq", "turtletopia", tag = "v0.1.0"
)
test_param_package(wood_github_dependencies, user = "turtletopia")
test_param_gh_user(wood_github_dependencies, package = "gglgbtq")
test_param_tag(wood_github_dependencies, package = "gglgbtq", user = "turtletopia")

vcr::use_cassette("gglgbtq-deps-cache", {
  test_that("uses cache from wood_github_versions() if available if not latest commit", {
    wood_clear_cache()
    wood_github_versions("gglgbtq", "turtletopia")
    expect_cache(wood_github_dependencies, gglgbtq_deps,
                 package = "gglgbtq",
                 user = "turtletopia",
                 tag = "v0.1.0")
  })
})

vcr::use_cassette("gglgbtq-deps-latest", {
  test_that("uses cache from wood_github_latest() if available if latest commit", {
    gglgbtq_deps_latest <- wood_github_dependencies(
      "gglgbtq", "turtletopia", tag = "latest"
    )
    wood_clear_cache()
    wood_github_latest("gglgbtq", "turtletopia")
    expect_cache(wood_github_dependencies, gglgbtq_deps_latest,
                 package = "gglgbtq",
                 user = "turtletopia",
                 tag = "latest")
  })
})

vcr::use_cassette("fakepackage-github-deps", {
  test_that("raises an exception if package not available", {
    expect_error(
      wood_github_dependencies("fakepackage", "turtletopia"),
      "Can't find repository `turtletopia/fakepackage` on Github.",
      fixed = TRUE
    )
  })
})

vcr::use_cassette("fakepackage-github-deps-2", {
  test_that("raises an exception if version not available", {
    expect_error(
      wood_github_dependencies("gglgbtq", "turtletopia", tag = "v0.0.0"),
      "(i) Is `v0.0.0` a valid tag?",
      fixed = TRUE
    )
  })
})
