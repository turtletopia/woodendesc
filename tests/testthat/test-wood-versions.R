skip_if_not_installed("httptest2")
wood_clear_cache()

# SETUP ----
pkgs <- c("versionsort", "gglgbtq", "woodendesc")
with_mock_dir("2", {
  mixed_versions <- wood_versions(pkgs, repos = c("local#all", "cran"))
})

# TESTS ----
test_list_of(mixed_versions, pkgs, test_versions)
test_param_packages(wood_versions)
test_param_repos(wood_versions, packages = c("versionsort", "gglgbtq"))

# TODO: maybe add test whether version codes are sorted?
