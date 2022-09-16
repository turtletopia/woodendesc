skip_if_not_installed("vcr")
wood_clear_cache()

# SETUP ----
# Re-record on older R versions since it queries for PACKAGES without .gz
vcr::use_cassette("RDG-deps", {
  RGD_deps <- wood_url_dependencies(
    "RGraphicsDevice", "http://www.omegahat.net/R"
  )
}, record = "new_episodes")

# TESTS ----
test_dependencies(RGD_deps)
test_cache(
  wood_url_dependencies, RGD_deps, "RGraphicsDevice", "http://www.omegahat.net/R"
)
test_param_package(wood_url_dependencies, repository = "http://www.omegahat.net/R")
test_param_url_repo(wood_url_dependencies, package = "RGraphicsDevice")

test_that("raises an exception if package not available", {
  expect_error(
    wood_url_dependencies("fakepackage", "http://www.omegahat.net/R"),
    "Can't find package `fakepackage` on repository http://www.omegahat.net/R.",
    fixed = TRUE
  )
})
