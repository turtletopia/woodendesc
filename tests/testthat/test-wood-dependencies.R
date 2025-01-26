skip_if_not_installed("httptest2")
wood_clear_cache()

# SETUP ----
pkgs <- c("versionsort", "gglgbtq", "woodendesc")
with_mock_dir("z", {
  mixed_deps <- wood_dependencies(pkgs, repos = c("cran", "local#all"))
})

# TESTS ----
test_list_of(mixed_deps, pkgs, test_dependencies)
test_param_packages(wood_dependencies(packages = c("versionsort", "gglgbtq")))
test_param_repos(wood_dependencies(packages = c("versionsort", "gglgbtq")))

test_that("returns a 'wood_dep_list' object", {
  expect_s3_class(mixed_deps, "wood_dep_list")
})
